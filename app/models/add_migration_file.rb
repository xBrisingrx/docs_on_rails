class AddMigrationFile < ApplicationRecord
  belongs_to :record, polymorphic: true

  def self.vehicles_img
    files = AddMigrationFile.where( record_type: 'Vehicle' ).where( charge: false ).where(column: 'imagenes').where(active: true)
    files.each do |file|
      dir_file = Rails.root.join("app/#{file.path}")
      # if File.extname(dir_file) == '.'
      #   File.rename("#{dir_file}___", "#{dir_file}jpg")
      #   # file.update(path: )
      # end
      if dir_file.exist?
        vehicle = Vehicle.find( file.record_id )
        vehicle.images.attach( io: File.open("#{dir_file}"), filename: dir_file.basename  )
        file.update( charge: true )
      else
        file.update( exist_file: false )
      end
    end # each 
  end # method

  def self.change_img_name
    files = AddMigrationFile.where( record_type: 'Vehicle' ).where( column: 'imagenes' ).where(active: true)
    error_files = []
    files.each do |file|
      if file.path.split('.')[1] == nil
        # image = Rails.root.join("app/#{file.path}")
        # File.rename("#{image}___", "#{image}jpg")
        file.update( path: "#{file.path}jpg" )
        error_files << file.path 
        # image_2 = Rails.root.join("app/#{file.path}")
        # vehicle = Vehicle.find( file.record_id )
        # vehicle.images.attach( io: File.open("#{image_2}"), filename: image_2.basename  )
      end
    end
  end

  def self.people_files
    people = Person.all
    people.each do |person|
      dir_file_dni = Rails.root.join("app/assets/uploads/#{person.dni_pdf_path}")
      dir_file_cuil = Rails.root.join("app/assets/uploads/#{person.cuil_pdf_path}")
      dir_file_alta = Rails.root.join("app/assets/uploads/#{person.alta_pdf_path}")

      if dir_file_dni.exist? && !person.dni_file.attached?
        person.dni_file.attach( io: File.open("#{dir_file_dni}"), filename: dir_file_dni.basename  )
        AddMigrationFile.create( record: person, column: 'dni_file', path: "app/assets/uploads/#{person.dni_pdf_path}", exist_file: true, charge: true )
      elsif !dir_file_dni.exist?
        AddMigrationFile.create( record: person, column: 'dni_file', path: "app/assets/uploads/#{person.dni_pdf_path}", exist_file: false, charge: false )
      end

      if dir_file_cuil.exist? && !person.cuil_file.attached?
        person.cuil_file.attach( io: File.open("#{dir_file_cuil}"), filename: dir_file_cuil.basename  )
        AddMigrationFile.create( record: person, column: 'cuil_file', path: "app/assets/uploads/#{person.cuil_pdf_path}", exist_file: true, charge: true )
      elsif !dir_file_dni.exist?
        AddMigrationFile.create( record: person, column: 'cuil_file', path: "app/assets/uploads/#{person.cuil_pdf_path}", exist_file: false, charge: false )
      end

      if dir_file_alta.exist? && !person.start_activity_file.attached?
        person.start_activity_file.attach( io: File.open("#{dir_file_alta}"), filename: dir_file_alta.basename  )
        AddMigrationFile.create( record: person, column: 'start_activity_file', path: "app/assets/uploads/#{person.alta_pdf_path}", exist_file: true, charge: true )
      elsif !dir_file_dni.exist?
        AddMigrationFile.create( record: person, column: 'start_activity_file', path: "app/assets/uploads/#{person.alta_pdf_path}", exist_file: false, charge: false )
      end
    end # each 
  end

  def self.charge_document_renovacions
    files = AddMigrationFile.where( record_type: 'DocumentRenovation' ).where( charge: false )
    files.each do |file|
      renovation_file = Rails.root.join("app/#{file.path}")
      if renovation_file.exist?
        dr = DocumentRenovation.find_by( id: file.record_id )
        next if dr.blank?

        dr.files.attach( io: File.open("#{renovation_file}"), filename: renovation_file.basename )
        file.update( charge: true )
      else
        file.update( exist_file: false )
      end
    end
  end

  def self.document_renovation_file
    document_renovations = DocumentRenovation.where('id > ? ', 1)
    document_renovations.each do |renovation|
      d_type = renovation.assignments_document.assignated_type
      folder = 'app/assets/uploads/renovaciones_atributos/'
      folder += ( d_type == 'Person' ) ? 'personas' : 'vehiculos'
      file = Rails.root.join("#{folder}/#{renovation.pdf_path}")
      # byebug
      if file.exist? && !renovation.pdf_path.blank?
        if renovation.pdf_path.include?(" ")
          file_name = file.sub(' ', '_')
          File.rename(file, file_name)
          renovation.update(pdf_path: file_name.basename.to_s)
          file = file_name
        end        
        renovation.files.attach( io: File.open("#{file}"), filename: file.basename )
        AddMigrationFile.create( record: renovation, column: 'renovation', path: "#{folder}/#{renovation.pdf_path}", exist_file: true, charge: true )
      else
        AddMigrationFile.create( record: renovation, column: 'renovation', path: "#{folder}/#{renovation.pdf_path}", exist_file: false, charge: false )
      end
    end
  end

end
