-- Git browse: branch → commit → file (read-only via fugitive)
-- Dependencias: telescope.nvim, vim-fugitive

local function git_browse_files()
	local builtin = require("telescope.builtin")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local finders = require("telescope.finders")
	local pickers = require("telescope.pickers")
	local conf = require("telescope.config").values

	-- Picker 1: ramas locales + remotas
	builtin.git_branches({
		attach_mappings = function(prompt_bufnr, _)
			actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				if not selection then return end

				local ref = selection.value:gsub("%s*%(tag%)%s*$", "")

				-- Picker 2: commits de la rama seleccionada
				pickers.new({}, {
					prompt_title = "Commits in " .. ref,
					finder = finders.new_oneshot_job(
						{ "git", "log", ref, "--format=%H %s" },
						{
							entry_maker = function(line)
								if line == "" then return nil end
								local hash, msg = line:match("^(%S+)%s+(.-)$")
								if not hash then return nil end
								return {
									value = hash,
									display = hash:sub(1, 7) .. "  " .. (msg or ""),
									ordinal = (msg or "") .. " " .. hash,
								}
							end,
						}
					),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr2, _)
						actions.select_default:replace(function()
							local commit_sel = action_state.get_selected_entry()
							actions.close(prompt_bufnr2)
							if not commit_sel then return end

							local hash = commit_sel.value

							-- Picker 3: archivos del commit seleccionado
							builtin.find_files({
								prompt_title = "Files @" .. hash:sub(1, 7),
								find_command = { "git", "ls-tree", "-r", "--name-only", hash },
								attach_mappings = function(prompt_bufnr3, map3)
									local function open_file(mods)
										return function()
											local file_sel = action_state.get_selected_entry()
											actions.close(prompt_bufnr3)
											if not file_sel then return end

											local path = vim.fn.fnameescape(file_sel[1])
											if mods then
												vim.cmd(mods .. " Gedit " .. hash .. ":" .. path)
											else
												vim.cmd("Gedit " .. hash .. ":" .. path)
											end
										end
									end

									actions.select_default:replace(open_file(nil))
									map3("i", "<C-v>", open_file("vertical"))
									map3("i", "<C-x>", open_file("horizontal"))
									map3("i", "<C-t>", open_file("tab"))
									return true
								end,
							})
						end)
						return true
					end,
				}):find()
			end)
			return true
		end,
	})
end

vim.keymap.set("n", "<leader>gb", git_browse_files, { desc = "Git browse: branch → commit → file" })
