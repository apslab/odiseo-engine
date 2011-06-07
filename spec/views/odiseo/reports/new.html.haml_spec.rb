require 'spec_helper'

describe "odiseo/reports/new.html.haml" do
  before(:each) do
    assign(:odiseo_report, stub_model(Odiseo::Report).as_new_record)
  end

  it "renders new odiseo_report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => odiseo_reports_path, :method => "post" do
    end
  end
end
