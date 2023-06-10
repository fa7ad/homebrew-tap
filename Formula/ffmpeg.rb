class Ffmpeg < Formula
  desc "Play, record, convert, and stream audio and video"
  homepage "https://ffmpeg.org/"
  license "GPL-2.0-or-later"
  version "6.0"

  url "https://www.osxexperts.net/ffmpeg6arm.zip"
  sha256 "15e67ff413d3d2436ddb3efd282344e50b8f1c6f834979b984371b90ebaf0449"

  on_intel do
    url "https://www.osxexperts.net/ffmpeg6intel.zip"
    sha256 "034a8d6eafb2736711d98e897dc22cc5769c7c31bde9a40ac20f58cbd57f68d8"
  end

  resource "ffprobe" do
    version "6.0"
    on_arm do
      url "https://www.osxexperts.net/ffprobe6arm.zip"
      sha256 "582842ca7e76197ae8f4299b7f5f2d257b42168f314fc37a675708b9d5f847e0"
    end
    on_intel do
      url "https://www.osxexperts.net/ffprobe6intel.zip"
      sha256 "5ed6e3a619edd06d81c506e085aeef85e3f5b5bcc34d032b01bb1b125413cd03"
    end
  end

  resource "ffplay" do
    version "6.0"
    on_arm do
      url "https://www.osxexperts.net/ffplay6arm.zip"
      sha256 "bd8487c83b58b00957d7b4d6e51abb80c5354ad272732fdd9cef4ee554723555"
    end
    on_intel do
      url "https://www.osxexperts.net/ffplay6intel.zip"
      sha256 "fdfe3e7e0c0c4435ad1dc31d11a6e2a016b1a2559f93e19f6d9af8ced56340d6"
    end
  end

  livecheck do
    url "https://ffmpeg.org/download.html"
    regex(/href=.*?ffmpeg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  def install
    prefix.install "ffmpeg"
    resource("ffprobe").stage { prefix.install "ffprobe" }
    resource("ffplay").stage { prefix.install "ffplay" }
    bin.install_symlink prefix/"ffmpeg" => "ffmpeg"
    bin.install_symlink prefix/"ffprobe" => "ffprobe"
    bin.install_symlink prefix/"ffplay" => "ffplay"
  end

  def caveats
    <<~EOS
      This Formula uses static builds, some functionality may be missing.
    EOS
  end

  test do
    # Create an example mp4 file
    mp4out = testpath/"video.mp4"
    system bin/"ffmpeg", "-filter_complex", "testsrc=rate=1:duration=1", mp4out
    assert_predicate mp4out, :exist?
  end
end
