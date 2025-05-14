require 'net/http'
require 'uri'

class Piston
  @@conn = Faraday.new(
    url: 'http://162.55.36.115:2000',
    headers: {'Content-Type' => 'application/json'}
  )

  def self.runtimes(cache = false)
    @@runtimes ||= pr(@@conn.get('/api/v2/runtimes'))
    @@runtimes = pr(@@conn.get('/api/v2/runtimes')) if !cache
    @@runtimes
  end

  def self.packages
    pr @@conn.get('/api/v2/packages')
  end

  def self.install_package(language:, version:)
    r = @@conn.post('/api/v2/packages') do |req|
      req.body = {
        language: language,
        version: version
      }.to_json
    end
    pr r
  end

  def self.exec(language, version: nil, input: nil)
    version ||= runtimes(true).find{it["language"] == language.to_s}["version"]
    r = @@conn.post('/api/v2/execute') do |req|
      req.body = {
        language:,
        version:,
        files: [name: "x.py", content: yield],
        stdin: input
      }.to_h.to_json
    end
    pr r
  end

  def self.test
    exec(:python) do
      "print('lol')"
    end
  end

  def self.pr(r)
    JSON.parse(r.body)
  end
end
