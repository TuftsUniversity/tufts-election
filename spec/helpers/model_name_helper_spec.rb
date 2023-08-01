# frozen_string_literal: true
require 'rails_helper'

describe ModelNameHelper do
  describe '#map_model_name' do
    it 'maps non expected name to it self' do
      expect(described_class.map_model_name("random class name")).to eq "random class name"
    end
    it 'maps Audio' do
      expect(described_class.map_model_name("info:fedora/cm:Audio")).to eq "info:fedora/afmodel:TuftsAudio"
    end
    it 'maps Oral History' do
      expect(described_class.map_model_name("info:fedora/cm:Audio.OralHistory")).to eq "info:fedora/afmodel:TuftsAudioText"
    end
    it 'maps Image' do
      expect(described_class.map_model_name("info:fedora/cm:Image.3DS")).to eq "info:fedora/afmodel:TuftsImage"
      expect(described_class.map_model_name("info:fedora/cm:Image.4DS")).to eq "info:fedora/afmodel:TuftsImage"
    end
    it 'maps Image Text' do
      expect(described_class.map_model_name("info:fedora/cm:Image.HTML")).to eq "info:fedora/afmodel:TuftsImageText"
    end
    it 'maps WP' do
      expect(described_class.map_model_name("info:fedora/cm:WP")).to eq "info:fedora/afmodel:TuftsWP"
    end
    it 'maps Faculty Publications' do
      expect(described_class.map_model_name("info:fedora/cm:Text.FacPub")).to eq "info:fedora/afmodel:TuftsFacultyPublication"
    end
    it 'maps PDF' do
      expect(described_class.map_model_name("info:fedora/cm:Text.PDF")).to eq "info:fedora/afmodel:TuftsPdf"
    end
    it 'maps Generic Object' do
      expect(described_class.map_model_name("info:fedora/cm:Object.Generic")).to eq "info:fedora/afmodel:TuftsGenericObject"
    end
    it 'maps TEI Fragment' do
      expect(described_class.map_model_name("info:fedora/cm:Text.TEI-Fragmented")).to eq "info:fedora/afmodel:TuftsTeiFragmented"
    end
    it 'maps TEI' do
      expect(described_class.map_model_name("info:fedora/cm:Text.TEI")).to eq "info:fedora/afmodel:TuftsTEI"
    end
    it 'maps RCR' do
      expect(described_class.map_model_name("info:fedora/cm:Text.RCR")).to eq "info:fedora/afmodel:TuftsRCR"
    end
    it 'maps Voting Record' do
      expect(described_class.map_model_name("info:fedora/cm:VotingRecord")).to eq "info:fedora/afmodel:TuftsVotingRecord"
    end
  end

  describe '#map_model_names' do
    it 'maps model names' do
      model_names = ["info:fedora/cm:Audio", "info:fedora/cm:Audio.OralHistory", "info:fedora/cm:Image.3DS", "info:fedora/cm:Image.4DS", "info:fedora/cm:Text.RCR", "info:fedora/cm:VotingRecord"]
      mapped_names = ["info:fedora/afmodel:TuftsAudio", "info:fedora/afmodel:TuftsAudioText", "info:fedora/afmodel:TuftsImage", "info:fedora/afmodel:TuftsImage", "info:fedora/afmodel:TuftsRCR", "info:fedora/afmodel:TuftsVotingRecord"]
      expect(described_class.map_model_names(model_names)).to eq mapped_names
    end
  end
end
