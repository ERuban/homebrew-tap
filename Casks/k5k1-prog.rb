cask "k5k1-prog" do
  version "2.0.2"
  sha256 "75caa37abb3e7b8fb664bdff3eb0a6f775608a3e4e1cf2e08fa70e46ea2a22cc"

  url "https://github.com/ERuban/k5k1prog-mac/releases/download/v#{version}/K5K1-Prog-#{version}.zip"
  name "K5K1 Prog"
  desc "Back up, restore and flash Quansheng UV-K5 / UV-K5 V3 / UV-K1 radios"
  homepage "https://github.com/ERuban/k5k1prog-mac"

  livecheck do
    url :url
    strategy :github_latest
  end

  # No `auto_updates true`: the app updates itself with Sparkle too, but `brew upgrade` should
  # still pick up every new release.
  depends_on macos: :monterey

  app "K5K1 Prog.app"

  zap trash: [
    "~/Library/Caches/io.github.eruban.k5k1prog",
    "~/Library/HTTPStorages/io.github.eruban.k5k1prog",
    "~/Library/Preferences/io.github.eruban.k5k1prog.plist",
  ]
end
