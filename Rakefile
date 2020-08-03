require 'rake/testtask'

Rake::TestTask.new do |t|
    t.pattern = "test/**/*_test.rb"
end

# require 'rake/testtask'
#
# Rake::TestTask.new(:test) do |t|
#   t.libs << 'lib'
#   t.libs << 'test'
#   t.test_files = FileList['test/**/*_test.rb'].exclude('test/**/night*')
#   t = 'test/night_writer_test.rb message.txt braille.txt'
#   t.verbose = false
# end

task default: ["test"]
