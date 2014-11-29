module LseTimetable
  class TimetableItem
    attr_reader :course_title,
                :course_code,
                :type,
                :starts_at
                :finishes_at
                :location

    def initialize(node)
      @course_title = node["desc1"]
      @course_code = node["desc2"]
      @type = node["desc3"]
      @starts_at = DateTime.parse(node["start"])
      @finishes_at = DateTime.parse(node["end"])
      @location = node["locAdd3"]
    end
  end
end