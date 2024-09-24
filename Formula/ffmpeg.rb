
class Ffmpeg < Formula
  desc "Play, record, convert, and stream audio and video"
  homepage "https://ffmpeg.org/"
  license "GPL-2.0-or-later"
  version "7.0"

  _file_hashes = {
    "ffmpeg7arm.zip"    => "563111a239fe70d2e5c84a5382204a7d0bf0a332385a92a44baff36d313e27f2",
    "ffmpeg7intel.zip"  => "2d01a9bb00c3d0d4a850baa12a9414af197c1199315443bce44064ffb8e4297a",
    "ffplay7arm.zip"    => "d2bee00e6765649fc201814610dbf6932bb4eb3b2964c7c008534c0ba2cb97c0",
    "ffplay7intel.zip"  => "d018dd609980b62fd4e5e60c0f8e8853681fb3e6971c6dd25150088b57cd3a37",
    "ffprobe7arm.zip"   => "e5ae34ee2f0b3594892a695fd733646904bbc7eb40af3b359ed91538ddcb5513",
    "ffprobe7intel.zip" => "e14a2feb619ee21cb96ac3bf8c34a5d57f2ea61c38fe9d89b1a084d619b6aebf"
  }


  url "https://www.osxexperts.net/ffmpeg7arm.zip"
  sha256 _file_hashes["ffmpeg7arm.zip"]

  on_intel do
    url "https://www.osxexperts.net/ffmpeg7intel.zip"
    sha256 _file_hashes["ffmpeg7intel.zip"]
  end

  resource "ffprobe" do
    version "7.0"
    on_arm do
      url "https://www.osxexperts.net/ffprobe7arm.zip"
      sha256 _file_hashes["ffprobe7arm.zip"]
    end
    on_intel do
      url "https://www.osxexperts.net/ffprobe7intel.zip"
      sha256 _file_hashes["ffprobe7intel.zip"]
    end
  end

  resource "ffplay" do
    version "7.0"
    on_arm do
      url "https://www.osxexperts.net/ffplay7arm.zip"
      sha256 _file_hashes["ffplay7arm.zip"]
    end
    on_intel do
      url "https://www.osxexperts.net/ffplay7intel.zip"
      sha256 _file_hashes["ffplay7intel.zip"]
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
