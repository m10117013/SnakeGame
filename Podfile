# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SnakeGame' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!
	pod 'Masonry'
  # Pods for SnakeGame
	
  target 'SnakeGameTests' do
    inherit! :search_paths
    # Pods for testing
	   pod 'Specta', '~> 1.0'
    	 pod 'Expecta', '~> 1.0'
  end

  # Disable Code Coverage for Pods projects
  post_install do |installer_representation|
      installer_representation.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
          end
      end
  end
  
end
