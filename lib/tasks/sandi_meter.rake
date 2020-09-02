namespace :quality do
	desc 'Check that code follows Sandi Metz rules'
	task :sandi_meter do
		sh 'sandi_meter -g --output-path reports/sandi_meter --quiet'
	end
end
