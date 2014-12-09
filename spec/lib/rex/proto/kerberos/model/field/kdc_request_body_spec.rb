# -*- coding:binary -*-
require 'spec_helper'

require 'rex/proto/kerberos'

describe Rex::Proto::Kerberos::Model::Field::KdcRequestBody do

  subject(:kdc_request_body) do
    described_class.new
  end

  let(:as_req) { 10 }
  let(:tgs_req) { 12 }

  let(:sample_as_req) do
    "\x30\x81\x93\xa0\x07\x03\x05\x00" +
    "\x50\x80\x00\x00\xa1\x11\x30\x0f" +
    "\xa0\x03\x02\x01\x01\xa1\x08\x30" +
    "\x06\x1b\x04\x6a\x75\x61\x6e\xa2" +
    "\x0c\x1b\x0a\x44\x45\x4d\x4f\x2e" +
    "\x4c\x4f\x43\x41\x4c\xa3\x1f\x30" +
    "\x1d\xa0\x03\x02\x01\x01\xa1\x16" +
    "\x30\x14\x1b\x06\x6b\x72\x62\x74" +
    "\x67\x74\x1b\x0a\x44\x45\x4d\x4f" +
    "\x2e\x4c\x4f\x43\x41\x4c\xa4\x11" +
    "\x18\x0f\x31\x39\x37\x30\x30\x31" +
    "\x30\x31\x30\x30\x30\x30\x30\x30" +
    "\x5a\xa5\x11\x18\x0f\x31\x39\x37" +
    "\x30\x30\x31\x30\x31\x30\x30\x30" +
    "\x30\x30\x30\x5a\xa6\x11\x18\x0f" +
    "\x31\x39\x37\x30\x30\x31\x30\x31" +
    "\x30\x30\x30\x30\x30\x30\x5a\xa7" +
    "\x06\x02\x04\x18\xf4\x10\x2c\xa8" +
    "\x05\x30\x03\x02\x01\x17"
  end

  let(:sample_tgs_req) do
    "\x30\x82\x03\x18\xa0\x07\x03\x05\x00\x50\x80\x00\x00\xa2\x0c\x1b" +
    "\x0a\x44\x45\x4d\x4f\x2e\x4c\x4f\x43\x41\x4c\xa3\x1f\x30\x1d\xa0" +
    "\x03\x02\x01\x01\xa1\x16\x30\x14\x1b\x06\x6b\x72\x62\x74\x67\x74" +
    "\x1b\x0a\x44\x45\x4d\x4f\x2e\x4c\x4f\x43\x41\x4c\xa4\x11\x18\x0f" +
    "\x31\x39\x37\x30\x30\x31\x30\x31\x30\x30\x30\x30\x30\x30\x5a\xa5" +
    "\x11\x18\x0f\x31\x39\x37\x30\x30\x31\x30\x31\x30\x30\x30\x30\x30" +
    "\x30\x5a\xa6\x11\x18\x0f\x31\x39\x37\x30\x30\x31\x30\x31\x30\x30" +
    "\x30\x30\x30\x30\x5a\xa7\x06\x02\x04\x7a\x5f\xfa\xac\xa8\x05\x30" +
    "\x03\x02\x01\x17\xaa\x82\x02\x94\x30\x82\x02\x90\xa0\x03\x02\x01" +
    "\x17\xa2\x82\x02\x87\x04\x82\x02\x83\x8a\x30\x9d\x7c\xa7\xe4\x22" +
    "\x36\x0d\x44\xf5\xd1\x3a\x00\x8b\x37\x6e\x52\x20\xbc\xea\x8b\x70" +
    "\x66\xc0\x90\xc4\x28\x27\x31\xcf\x16\x2c\x7c\x20\x7c\xaa\x3c\xe0" +
    "\xc7\x6a\xfb\xb9\x41\xb2\xd9\xa2\xd8\x59\x92\xb5\x82\x17\x8a\x93" +
    "\x56\x51\x97\xf9\xad\x1d\xc6\xc6\xbc\xa0\x44\x9b\xc5\xc1\xd8\x31" +
    "\xf1\x94\x88\x37\x0b\xa5\xaf\x51\xb0\x3d\x9a\x6d\xc0\xb2\xf1\x20" +
    "\x33\xb7\x87\x7a\xcf\xf7\xde\xa0\x8b\x83\xae\x76\x71\x38\x7d\x42" +
    "\x4d\xde\x0a\x03\xbe\xb7\x1c\xf4\x8c\x84\x16\x35\x2e\x60\xc4\x83" +
    "\x17\x71\xe7\x00\x23\xfb\xa1\x01\xd3\xda\xe0\x7f\xcd\x04\x3d\x53" +
    "\x85\x4e\x72\x09\x63\xf4\x06\xd8\x51\x15\xab\x15\xec\x4f\x80\xc5" +
    "\xf3\xe2\x8a\x7f\x97\x0f\x71\xed\x0c\xe9\x9f\x19\x14\x6b\x3d\x94" +
    "\x4a\xae\x3e\xb8\x1a\x33\xc4\x56\xcf\x36\xf8\x56\x0a\xe9\xaf\x5c" +
    "\xb5\x42\x40\x72\xde\xd5\x95\x37\xa0\xe5\x93\xc3\x32\xef\x82\x0a" +
    "\x0f\x1e\x0a\x75\x20\xb6\x8d\xfc\xe2\xce\xb3\x87\xdf\xa5\x04\x67" +
    "\xf4\x30\x1a\x0a\x19\x38\x46\x5a\x58\x46\xf4\x34\xba\xdb\x46\x4e" +
    "\xc4\xcc\xaa\xbc\x24\x85\xa5\x24\x84\x96\xa4\x75\x43\x46\x7f\x11" +
    "\xce\x47\x9f\xfa\x84\xce\xb6\x35\xcd\x95\x1e\x1d\x03\x88\x1d\xe3" +
    "\x3a\x53\x9b\xa5\x1b\x97\x83\xcf\xb3\x9e\x88\x08\x86\x6d\x48\x98" +
    "\xec\x8d\x83\x42\xae\xc9\x92\x56\xd5\xa9\x90\x03\x47\xb8\xd7\x81" +
    "\xf4\x6e\x1e\x6d\x73\x8a\x3a\xc6\x0f\xb1\x38\x99\x4f\x06\x04\x11" +
    "\x7d\xa3\x39\x34\xa9\x9e\x8e\x48\xcc\x64\xf3\x33\x3c\x0b\x88\x3e" +
    "\x42\xf8\x74\x3e\x92\x68\x67\x26\xeb\x46\xaa\xc8\x31\x77\x4b\xb1" +
    "\x57\xef\x49\xd3\x98\xf5\x53\xc0\x58\x19\x26\xb7\x1b\x8c\x17\x77" +
    "\xbc\xe0\x20\xe9\x80\x08\xe5\x92\x27\x72\x53\x20\x09\xc6\x39\x02" +
    "\x97\x4b\x0a\x54\x8c\x2d\x0c\xbd\x65\x9c\x61\x54\xef\x90\x6d\xc6" +
    "\x56\x62\xc8\x04\xd7\x6b\x23\xd1\xb0\xc7\xe7\xe5\x36\x96\x05\xf9" +
    "\x46\x01\xc1\xac\x0c\x96\x84\xaa\x6c\x84\x58\xde\xad\xe7\x32\x85" +
    "\x2c\xfd\x27\x1a\xdc\x39\x60\xbc\x5e\x0d\x7e\x1d\x65\x7f\x21\xfa" +
    "\xcd\xc3\x30\xb3\xee\x00\xc9\xf8\x1e\x0f\xb5\x67\x87\xa0\xaf\x46" +
    "\xe3\x55\xff\x0c\x0c\x63\x8e\xdb\xd9\x11\x9c\x17\x5a\x87\xb0\xf2" +
    "\x51\x56\x62\x7f\x7e\x64\x53\xaf\x04\x77\xfb\xec\xa7\x96\x98\x93" +
    "\x96\x10\x39\x72\xf0\x44\xfa\x66\x7f\x00\xe0\xe9\x9f\x36\xbc\x81" +
    "\x87\x2e\xfb\x6d\xc0\x9b\x52\xb2\x19\xa5\xbf\x8c\x0f\x33\x19\x0b" +
    "\x41\xce\xf5\x6f\x6f\xd7\x2b\x04\xe0\xa7\xad\x40\x32\x8d\xf3\xbe" +
    "\x13\xc7\xc6\x21\xed\x23\x10\xc5\x1a\x9f\x82\x99\x62\x37\x71\xe4" +
    "\xb8\x69\x0a\xa8\x88\xeb\xcb\xc0\x1c\xdf\x54\x6f\x4c\x43\x90\x12" +
    "\xcf\x29\xb0\xf1\xc9\xfd\x4b\x5e\x44\x08\x25\x8d\x64\x45\x3e\xbc" +
    "\x7e\xb1\x67\x80\xc3\x39\x1e\xe8\xbf\xe0\x90\x70\xf8\x00\xcf\x18" +
    "\x29\xab\x72\x01\x0c\x43\x02\x0b\x81\x7b\x1a\xac\xf5\x25\x33\x53" +
    "\x86\xf5\x25\xef\x7f\x1d\x1d\x05\x3f\x12\x38\x4a\x3f\x98\x03\xc8" +
    "\x9f\xf3\x9b\x87\x80\xb2\x4f\xcd\x3d\x3d\x58\xb5"
  end

  describe ".new" do
    it "returns a Rex::Proto::Kerberos::Model::Type::KdcRequestBody" do
      expect(kdc_request_body).to be_a(Rex::Proto::Kerberos::Model::Field::KdcRequestBody)
    end
  end

  describe "#decode" do
    context "when KdcRequestBody from a KRB_AS_REQ message" do
      it "returns the KdcRequestBody instance" do
        expect(kdc_request_body.decode(sample_as_req, as_req)).to eq(kdc_request_body)
      end

      it "decodes options" do
        kdc_request_body.decode(sample_as_req, as_req)
        expect(kdc_request_body.options).to eq(0x50800000)
      end

      it "decodes cname" do
        kdc_request_body.decode(sample_as_req, as_req)
        expect(kdc_request_body.cname.name_string).to eq(['juan'])
      end

      it "decodes realm" do
        kdc_request_body.decode(sample_as_req, as_req)
        expect(kdc_request_body.realm).to eq('DEMO.LOCAL')
      end

      it "decodes sname" do
        kdc_request_body.decode(sample_as_req, as_req)
        expect(kdc_request_body.sname.name_string).to eq(['krbtgt', 'DEMO.LOCAL'])
      end

      it "decodes from" do
        kdc_request_body.decode(sample_as_req, as_req)
        expect(kdc_request_body.from.to_s).to eq('1970-01-01 00:00:00 UTC')
      end

      it "decodes till" do
        kdc_request_body.decode(sample_as_req, as_req)
        expect(kdc_request_body.till.to_s).to eq('1970-01-01 00:00:00 UTC')
      end

      it "decodes rtime" do
        kdc_request_body.decode(sample_as_req, as_req)
        expect(kdc_request_body.rtime.to_s).to eq('1970-01-01 00:00:00 UTC')
      end

      it "decodes nonce" do
        kdc_request_body.decode(sample_as_req, as_req)
        expect(kdc_request_body.nonce).to eq(418648108)
      end

      it "decodes etype" do
        kdc_request_body.decode(sample_as_req, as_req)
        expect(kdc_request_body.etype).to eq([23])
      end

      it "doesn't decode enc_auth_data" do
        kdc_request_body.decode(sample_as_req, as_req)
        expect(kdc_request_body.enc_auth_data).to be_nil
      end

    end

    context "when KdcRequestBody from a KRB_TGS_REQ message" do
      it "returns the KdcRequestBody instance" do
        expect(kdc_request_body.decode(sample_tgs_req, tgs_req)).to eq(kdc_request_body)
      end

      it "decodes options" do
        kdc_request_body.decode(sample_tgs_req, tgs_req)
        expect(kdc_request_body.options).to eq(0x50800000)
      end

      it "leaves cname as nil" do
        kdc_request_body.decode(sample_tgs_req, tgs_req)
        expect(kdc_request_body.cname).to be_nil
      end

      it "decodes realm" do
        kdc_request_body.decode(sample_tgs_req, tgs_req)
        expect(kdc_request_body.realm).to eq('DEMO.LOCAL')
      end

      it "decodes sname" do
        kdc_request_body.decode(sample_tgs_req, tgs_req)
        expect(kdc_request_body.sname.name_string).to eq(['krbtgt', 'DEMO.LOCAL'])
      end

      it "decodes from" do
        kdc_request_body.decode(sample_tgs_req, tgs_req)
        expect(kdc_request_body.from.to_s).to eq('1970-01-01 00:00:00 UTC')
      end

      it "decodes till" do
        kdc_request_body.decode(sample_tgs_req, tgs_req)
        expect(kdc_request_body.till.to_s).to eq('1970-01-01 00:00:00 UTC')
      end

      it "decodes rtime" do
        kdc_request_body.decode(sample_tgs_req, tgs_req)
        expect(kdc_request_body.rtime.to_s).to eq('1970-01-01 00:00:00 UTC')
      end

      it "decodes nonce" do
        kdc_request_body.decode(sample_tgs_req, tgs_req)
        expect(kdc_request_body.nonce).to eq(2053110444)
      end

      it "decodes etype" do
        kdc_request_body.decode(sample_tgs_req, tgs_req)
        expect(kdc_request_body.etype).to eq([23])
      end

      it "decodes enc_auth_data" do
        kdc_request_body.decode(sample_tgs_req, tgs_req)
        expect(kdc_request_body.enc_auth_data.cipher.length).to eq(643)
      end
    end
  end
end
