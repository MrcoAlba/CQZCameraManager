Pod::Spec.new do |s|
	s.name 				= 'CQZCameraManager'
  	s.version			= '0.5.0'
  	s.summary 			= 'CameraManager'
  	s.homepage 			= 'https://github.com/anthonyqz/CQZCameraManager.git'
  	s.author 			= { "Christian Quicano" => "anthony.qz@ecorenetworks.com" }
  	s.source 			= {:git => 'https://github.com/anthonyqz/CQZCameraManager', :tag => s.version}
  	s.ios.deployment_target 	= '13.0'
  	s.requires_arc 			= true
	s.frameworks             	= "Foundation"
	s.source_files			= 'project/CameraManager/*.swift'
end