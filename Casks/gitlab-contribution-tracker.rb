cask "gitlab-contribution-tracker" do
  version "1.0.2"

  on_arm do
    url "https://github.com/Acanguven/gitlab-contribution-tracker/releases/download/v#{version}/GitLab-Tracker-arm64.zip"
    sha256 "1f9a0ad78f90fc558e2451c879d3c27fda0e271fe85e750466f54f3c2a788eb9"
  end

  on_intel do
    url "https://github.com/Acanguven/gitlab-contribution-tracker/releases/download/v#{version}/GitLab-Tracker-x86_64.zip"
    sha256 "2822c2e9f7ccb17e5993c471a843d36389902ca2d42b2b41dda997a43c65c8a6"
  end

  name "GitLab Contribution Tracker"
  desc "macOS menu bar app that tracks daily GitLab push events"
  homepage "https://github.com/Acanguven/gitlab-contribution-tracker"

  app "GitLab Tracker.app"

  postflight do
    system_command "/usr/bin/xattr",
         args: ["-dr", "com.apple.quarantine", "#{appdir}/GitLab Tracker.app"]
    system_command "/usr/bin/osascript",
         args: ["-e", 'tell application "System Events" to make login item at end with properties {path:"/Applications/GitLab Tracker.app", hidden:true}']
    system_command "/usr/bin/open",
         args: ["#{appdir}/GitLab Tracker.app"]
  end

  uninstall_postflight do
    system_command "/usr/bin/osascript",
         args: ["-e", 'tell application "System Events" to delete login item "GitLab Tracker"'],
         must_succeed: false
  end

  zap trash: "~/.config/gitlab-contribution-tracker"
end
