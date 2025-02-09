class PipTools < Formula
  include Language::Python::Virtualenv

  desc "Locking and sync for Pip requirements files"
  homepage "https://pip-tools.readthedocs.io"
  url "https://files.pythonhosted.org/packages/8d/16/981bf78d74531e022b5f139c3641d121afd3272a2ddfe7fa023c1e288f37/pip-tools-6.6.1.tar.gz"
  sha256 "634e3e8d4707257c004313d16a9d6c14c1ce94d3c0fa1f93c38d264401f2e4f2"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1a474103e94153fc2da4633daff30ed35e931e7a503802b2dbe0d27a1a9b1b09"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e753115a780388e20abe7c100f45a1ec946585f1f5a156e14dc529fc2f35c465"
    sha256 cellar: :any_skip_relocation, monterey:       "5231b2cc4de3446de4fbae91af4d6cd5c214339d772b7e1c6ac4fa61fb538ea3"
    sha256 cellar: :any_skip_relocation, big_sur:        "e81556238ef4dd7af041ab4a1d020f9ea6932ceffdf0bf9476fbe97bff9c816e"
    sha256 cellar: :any_skip_relocation, catalina:       "7d28b9b529c0cf0b48f0eb354f25757646155f2596c891a079d88b1bea3a7dc2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6e5c00c0d2a547c7d544beefb76fd56367e84747419e4b571da2b93d011729a3"
  end

  depends_on "python@3.10"

  resource "click" do
    url "https://files.pythonhosted.org/packages/59/87/84326af34517fca8c58418d148f2403df25303e02736832403587318e9e8/click-8.1.3.tar.gz"
    sha256 "7682dc8afb30297001674575ea00d1814d808d6a36af415a82bd481d37ba7b8e"
  end

  resource "pep517" do
    url "https://files.pythonhosted.org/packages/0a/65/6e656d49c679136edfba25f25791f45ffe1ea4ae2ec1c59fe9c35e061cd1/pep517-0.12.0.tar.gz"
    sha256 "931378d93d11b298cf511dd634cf5ea4cb249a28ef84160b3247ee9afb4e8ab0"
  end

  resource "tomli" do
    url "https://files.pythonhosted.org/packages/c0/3f/d7af728f075fb08564c5949a9c95e44352e23dee646869fa104a3b2060a3/tomli-2.0.1.tar.gz"
    sha256 "de526c12914f0c550d15924c62d72abc48d6fe7364aa87328337a31007fe8a4f"
  end

  resource "wheel" do
    url "https://files.pythonhosted.org/packages/c0/6c/9f840c2e55b67b90745af06a540964b73589256cb10cc10057c87ac78fc2/wheel-0.37.1.tar.gz"
    sha256 "e9a504e793efbca1b8e0e9cb979a249cf4a0a7b5b8c9e8b65a5e39d49529c1c4"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"requirements.in").write <<~EOS
      pip-tools
      typing-extensions
    EOS

    compiled = shell_output("#{bin}/pip-compile requirements.in -q -o -")
    assert_match "This file is autogenerated by pip-compile", compiled
    assert_match "# via pip-tools", compiled
  end
end
