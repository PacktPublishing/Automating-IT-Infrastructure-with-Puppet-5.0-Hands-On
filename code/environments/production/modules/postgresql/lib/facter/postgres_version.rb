Facter.add('postgres_version') do
  setcode do
    begin
      Facter::Core::Execution.execute("/bin/psql --version | awk '{print $3}'")
    rescue Facter::Core::Execution::ExecutionFailure
      'n/a'
    end
  end
end
