cask "gitlab-contribution-tracker" do
  version "1.0.3"

  on_arm do
    url "https://github.com/Acanguven/gitlab-contribution-tracker/releases/download/v#{version}/GitLab-Tracker-arm64.zip"
    sha256 "ecbef74d928324cb574d9008f8c9605a83930b73918421539e38f8677eeba500"
  end

  on_intel do
    url "https://github.com/Acanguven/gitlab-contribution-tracker/releases/download/v#{version}/GitLab-Tracker-x86_64.zip"
    sha256 "0a1c85a6cd9bba5bca35cec5a12e2bb7cc1ee35f024838f703dfcc5619d09639"
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
