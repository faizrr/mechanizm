object @events

attributes :title, :text

node(:start) { |r| r.start_datetime.to_i }
node(:end) { |r| r.end_datetime.to_i }