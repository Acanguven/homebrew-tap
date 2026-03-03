cask "gitlab-contribution-tracker" do
  version "1.0.0"

  on_arm do
    url "https://github.com/Acanguven/gitlab-contribution-tracker/releases/download/v#{version}/GitLab-Tracker-arm64.zip"
    sha256 "629660466fde951a4a7b7486e6ae57340959c585dfbd8b58eac41a11a5d85bd4"
  end

  on_intel do
    url "https://github.com/Acanguven/gitlab-contribution-tracker/releases/download/v#{version}/GitLab-Tracker-x86_64.zip"
    sha256 "7f1277900e2a4490cb9877b69f12d0903d7f7b6ff9063c1fa3b8b98a8b22b4b9"
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
  end

  uninstall_postflight do
    system_command "/usr/bin/osascript",
                   args: ["-e", 'tell application "System Events" to delete login item "GitLab Tracker"'],
                   must_succeed: false
  end

  zap trash: "~/.config/gitlab-contribution-tracker"
end
