local colo_status, colorizer = pcall(require, 'colorizer')
if not colo_status then
	return
end

colorizer.setup()
