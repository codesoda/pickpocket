module Task
  def self.types
    @@types ||= ObjectSpace.each_object(Class)
      .select { |klass| klass < Task::Base }
      .inject({}) { |m, k| m.merge(k.name.split('::').last.downcase => k) }
  end

  def self.run(type, pocket, config)
    task = self.types[type]
    task.run(pocket, config)
  end
end
