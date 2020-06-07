platform :ios, '11.0'
use_frameworks!

inhibit_all_warnings!

workspace 'Demo.xcworkspace'

def shared_pods 

	pod 'RxSwift'
	pod 'RxCocoa'
	pod 'RxOptional'
	pod 'RxSwiftExt'
	pod 'Swinject'
end

target 'App' do
	project 'App/App.xcodeproj'

	shared_pods

	pod 'RxCells'
	pod 'Kingfisher'
end

target 'Domain' do
	project 'Domain/Domain.xcodeproj'

	shared_pods
end

target 'Data' do
	project 'Data/Data.xcodeproj'

	shared_pods
end
