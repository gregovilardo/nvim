local M = {}

local NOTES_DIR = vim.fn.expand("$HOME/Documents/Notes")
local CACHE_DIR = vim.fn.expand("$HOME/.cache/notes")
local LAST_NOTE_FILE = CACHE_DIR .. "/last_note.txt"

vim.fn.mkdir(CACHE_DIR, "p")

local group = vim.api.nvim_create_augroup("NotesSession", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = group,
	pattern = { "*.md" },
	callback = function()
		local path = vim.fn.expand("%:p")
		if not path:find(NOTES_DIR, 1, true) then
			return
		end
		local f = io.open(LAST_NOTE_FILE, "w")
		if f then
			f:write(path .. "\n")
			f:close()
		end
	end,
})

function M.get_last_note()
	local f = io.open(LAST_NOTE_FILE, "r")
	if not f then
		return nil
	end
	local path = f:read("*l")
	f:close()
	if path and vim.fn.filereadable(path) == 1 then
		return path
	end
	return nil
end

function M.open_last()
	local path = M.get_last_note()
	if path then
		vim.cmd("edit " .. vim.fn.fnameescape(path))
	else
		vim.notify("No last note found", vim.log.levels.WARN)
	end
end

function M.open_tuxedo()
	local width = math.floor(vim.o.columns * 0.85)
	local height = math.floor(vim.o.lines * 0.75)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " Tuxedo ",
	})

	vim.fn.termopen("tuxedo", {
		on_exit = function()
			vim.schedule(function()
				pcall(vim.api.nvim_win_close, win, true)
				M.start()
			end)
		end,
	})
	vim.cmd("startinsert")
end

function M.new_note(title)
	if not title or title == "" then
		vim.ui.input({ prompt = "Note title: " }, function(input)
			if input and input ~= "" then
				M.new_note(input)
			end
		end)
		return
	end

	local name = title:gsub("%.md$", "")
	local full_path = NOTES_DIR .. "/" .. name .. ".md"

	if vim.fn.filereadable(full_path) == 1 then
		vim.notify("Note already exists", vim.log.levels.WARN)
		vim.cmd("edit " .. vim.fn.fnameescape(full_path))
		return
	end

	vim.fn.mkdir(vim.fn.fnamemodify(full_path, ":h"), "p")

	local date = os.date("%Y-%m-%d")
	local content = {
		"---",
		"created: " .. date,
		"tags: []",
		"references: []",
		"---",
		"",
	}

	local f = io.open(full_path, "w")
	if f then
		f:write(table.concat(content, "\n"))
		f:close()
	end

	vim.notify("Created: " .. vim.fn.fnamemodify(full_path, ":t"))
	vim.cmd("edit " .. vim.fn.fnameescape(full_path))
end

function M.start()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_name(buf, "notes://dashboard")

	local width = 44
	local height = 12
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " Notes ",
	})

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
		"",
		"  NOTES DASHBOARD",
		"  ===============",
		"",
		"  [1]  New Note",
		"  [2]  Oil.nvim",
		"  [3]  Tuxedo",
		"  [4]  Last Note",
		"  [5]  Search  (Telescope)",
		"",
		"  q    Close",
		"",
	})

	vim.bo[buf].modifiable = false
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "wipe"

	local function close()
		pcall(vim.api.nvim_win_close, win, true)
	end

	local mappings = {
		["1"] = function()
			close()
			M.new_note(nil)
		end,
		["2"] = function()
			close()
			require("oil").open(NOTES_DIR, { preview = {} })
		end,
		["3"] = function()
			close()
			vim.schedule(M.open_tuxedo)
		end,
		["4"] = function()
			close()
			M.open_last()
		end,
		["5"] = function()
			close()
			require("telescope.builtin").find_files({ cwd = NOTES_DIR })
		end,
		["q"] = close,
	}

	for key, fn in pairs(mappings) do
		vim.keymap.set("n", key, fn, { buffer = buf, silent = true, nowait = true })
	end
end

vim.api.nvim_create_user_command("NewNote", function(opts)
	M.new_note(opts.args)
end, { nargs = "?", force = true, desc = "Create a new note (omit .md). Usage: NewNote <path/to/title>" })

vim.api.nvim_create_user_command("LastNote", function()
	M.open_last()
end, { force = true, desc = "Open the last edited note" })

vim.api.nvim_create_user_command("NotesDashboard", function()
	M.start()
end, { force = true, desc = "Open the notes dashboard" })

vim.keymap.set("n", "<leader>nn", function()
	M.new_note(nil)
end, { desc = "[N]otes: [N]ew note" })
vim.keymap.set("n", "<leader>nl", function()
	M.open_last()
end, { desc = "[N]otes: [L]ast note" })
vim.keymap.set("n", "<leader>nd", function()
	M.start()
end, { desc = "[N]otes: [D]ashboard" })
vim.keymap.set("n", "<leader>tt", function()
	M.open_tuxedo()
end, { desc = "[T]ODO: [T]uxedo" })

return M
