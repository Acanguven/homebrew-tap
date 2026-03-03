cask "gitlab-contribution-tracker" do
  version "1.0.1"

  on_arm do
    url "https://github.com/Acanguven/gitlab-contribution-tracker/releases/download/v#{version}/GitLab-Tracker-arm64.zip"
    sha256 "fd8020869eba2e90642bd988b595ae6b685257deda03789af9e14e27ff71f212"
  end

  on_intel do
    url "https://github.com/Acanguven/gitlab-contribution-tracker/releases/download/v#{version}/GitLab-Tracker-x86_64.zip"
    sha256 "564fb2fd37e048e4e12c97cc74e0b25eaaa7fea797a163b9820123aa80fb4cbe"
  end

  name "GitLab Contribution Tracker"
  desc "macOS menu bar app that tracks daily GitLab push events"
  homepage "https://github.com/Acanguven/gitlab-contribution-tracker"

  app "GitLab Tracker.app"

  auto_updates true

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
