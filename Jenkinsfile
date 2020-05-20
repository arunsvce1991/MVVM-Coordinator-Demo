
def xcodeproj = 'MoviesApp.xcodeproj' 
def build_scheme = 'MoviesApp'
def test_scheme = 'MoviesApp'
def simulator_device = 'iPhone 11'

node {
stage("Source Checkout") {
checkout scm
}

stage("Running Danger") {
sh "danger-swift ci"
}

stage("Running Tests") {

sh "/usr/local/bin/fastlane scan"
//sh "xcodebuild -scheme '${test_scheme}' -configuration Debug build test -destination 'platform=iOS Simulator,name=${simulator_device}'"

}
}