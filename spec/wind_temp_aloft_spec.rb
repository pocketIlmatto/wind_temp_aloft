require "spec_helper"
require "pry"

describe WindTempAloft do
  it "has a version number" do
    expect(WindTempAloft::VERSION).not_to be nil
  end

  it "returns an initial_instruction" do
    wta = WindTempAloft::Instruct.new()
    wta.initial_instruction
    expect { wta.initial_instruction }.to output("WindTempAloft\n").to_stdout
  end
end