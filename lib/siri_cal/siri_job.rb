class SiriJob < Struct.new(:obj_id, :obj_class)
  def obj
    @obj ||= obj_class.find(obj_id)
  end

  def perform
    obj.load_siri
  end
end