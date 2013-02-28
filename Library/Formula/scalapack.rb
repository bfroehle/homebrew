require 'formula'

class Scalapack < Formula
  homepage 'http://www.netlib.org/scalapack/'
  url 'http://www.netlib.org/scalapack/scalapack-2.0.2.tgz'
  sha1 'ff9532120c2cffa79aef5e4c2f38777c6a1f3e6a'

  depends_on MPIDependency.new(:cc, :f90)
  depends_on 'cmake' => :build
  depends_on 'dotwrp'

  option 'test', 'Verify the build with make test'

  def install
    ENV.fortran

    args = std_cmake_args + [
      '-DBLAS_LIBRARIES=-ldotwrp -Wl,-framework -Wl,Accelerate',
      '-DLAPACK_LIBRARIES=-ldotwrp -Wl,-framework -Wl,Accelerate',
    ]

    mkdir "build" do
      system 'cmake', '..', *args
      system 'make all'
      system 'make test' if build.include? 'test'
      system 'make install'
    end
  end
end
