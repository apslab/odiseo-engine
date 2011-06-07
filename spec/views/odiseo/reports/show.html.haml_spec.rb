require 'spec_helper'

describe "odiseo/reports/show.html.haml" do
  before(:each) do
    @odiseo_report = assign(:odiseo_report, stub_model(Odiseo::Report))
  end

  it "renders attributes in <p>" do
    render
  end
end
