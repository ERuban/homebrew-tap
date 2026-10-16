cask "k5k1-prog" do
  version "2.0.0"
  sha256 "c215026befd7e4a6529c02c928b8dc355b721c31e00e4fe8f7292034fab5d4c2"

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
