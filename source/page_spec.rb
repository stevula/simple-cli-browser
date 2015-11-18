require_relative 'page'

describe "Page" do
  let (:dbc) {Page.new("http://devbootcamp.com/schedule/")}

  it "should have a title" do
    title = "Dev Bootcamp | Upcoming Dev Bootcamp Classes"
    expect(dbc.fetch![:title]).to eq title
  end

  it "should know the content length" do
    expect(dbc.fetch![:content_length]).to eq 1572
  end

  it "should store a set of links" do
    link_list = dbc.fetch![:links]
    expect(link_list).to be_an Array
    expect(link_list[0]).to be_a String
    expect(link_list[-1]).to be_a String
  end
end
