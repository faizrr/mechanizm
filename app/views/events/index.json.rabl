object false
node :success do
    1
end
child @events, root:"result", object_root: false do
    attributes :id, :title
    node(:url) { "http://example.com" }
    node(:class) { "event-success" }
    node(:start) { |r| r.start_datetime.to_i*1000 }
    node(:end) { |r| r.end_datetime.to_i*1000 }
end