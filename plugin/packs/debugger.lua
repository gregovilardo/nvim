local dap = require("dap")
local dapui = require("dapui")
dapui.setup()
-- Configuración del adaptador para probe-rs
dap.adapters.probe_rs = {
	type = "server",
	port = "${port}",
	executable = {
		command = "probe-rs",
		args = { "dap-server", "--port", "${port}" },
	},
}

-- Configuración específica para archivos C
dap.configurations.c = {
	{
		name = "Debug STM32 (probe-rs)",
		type = "probe_rs",
		request = "launch",
		chip = "STM32H533RETx",
		before_launch = function()
			print("Compilando...")
			vim.fn.system("cmake --build build -j$(nproc)")
		end,
		coreConfigs = {
			{
				programBinary = "build/ProximityCarSensorTrigEcho.elf", --!TODO: Hacerlo automatico
			},
		},
	},
}

-- Abrir/cerrar la interfaz automáticamente
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
