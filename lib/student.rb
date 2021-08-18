class Student
  attr_accessor :name, :grade
  attr_reader :id
  #reader means that it cannot change

  def initalize(name, grade, id=nil)
    #id is optional because it will be created automaically
    @id = id
    @name = name
    @grade = grade 
  end 

  

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end 

  def save
    sql = <<-SQL 
    INSERT INTO students (name, grade)
    VALUES (?,?)
  SQL 

  DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save 
    student
  end 

end
