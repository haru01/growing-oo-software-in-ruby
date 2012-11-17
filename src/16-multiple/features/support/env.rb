require 'pp'
require 'logger'
require 'app/main'
require 'external/blocking-queue'

TestLogger = Logger.new($stdout)
TestLogger.level = Logger::WARN
App::Log.level = Logger::WARN
BlockingQueue::Log.level = Logger::WARN
SwingUtilities::Log.level = Logger::INFO
XMPP::Log.level = Logger::WARN

After do
  @auctions.each { | auction | auction.stop }
  @driver.stop
  @application.stop
end

# If you run into a situation where a next step starts before
# everything in the previous one is finished, you can use this at the
# end of the previous one.
def wait_for_quiet
  while ThreadGroup::Default.list.count > 1
    Thread.pass
  end
end
