require 'spec_helper'

describe Detail do
  pending "add some examples to (or delete) #{__FILE__}"
  
  before(:each) do
    @fetch = Detail.new
    @fetch.efetch.id = 22207904
    
    @detail = @fetch.efetch.do
  end
  
  context "do" do
    it "check return" do
      expected = {:PMID=>"22207904", :Title=>"Partial differential equation transform - Variational formulation and Fourier analysis.", :AuthorList=>"Yang Wang, Guo-Wei Wei, Siyang Yang", :Abstract=>"Nonlinear partial differential equation (PDE) models are established approaches for image/signal processing, data analysis and surface construction. Most previous geometric PDEs are utilized as low-pass filters which give rise to image trend information. In an earlier work, we introduced mode decomposition evolution equations (MoDEEs), which behave like high-pass filters and are able to systematically provide intrinsic mode functions (IMFs) of signals and images. Due to their tunable time-frequency localization and perfect reconstruction, the operation of MoDEEs is called a PDE transform. By appropriate selection of PDE transform parameters, we can tune IMFs into trends, edges, textures, noise etc., which can be further utilized in the secondary processing for various purposes. This work introduces the variational formulation, performs the Fourier analysis, and conducts biomedical and biological applications of the proposed PDE transform. The variational formulation offers an algorithm to incorporate two image functions and two sets of low-pass PDE operators in the total energy functional. Two low-pass PDE operators have different signs, leading to energy disparity, while a coupling term, acting as a relative fidelity of two image functions, is introduced to reduce the disparity of two energy components. We construct variational PDE transforms by using Euler-Lagrange equation and artificial time propagation. Fourier analysis of a simplified PDE transform is presented to shed light on the filter properties of high order PDE transforms. Such an analysis also offers insight on the parameter selection of the PDE transform. The proposed PDE transform algorithm is validated by numerous benchmark tests. In one selected challenging example, we illustrate the ability of PDE transform to separate two adjacent frequencies of sin(x) and sin(1.1x). Such an ability is due to PDE transform's controllable frequency localization obtained by adjusting the order of PDEs. The frequency selection is achieved either by diffusion coefficients or by propagation time. Finally, we explore a large number of practical applications to further demonstrate the utility of proposed PDE transform.", :Journal=>"Int j numer method biomed eng"}      
      expect(@fetch.do).to eq(expected)
    end
    
  end
    
  context "structure" do
    it "check return" do
      expected = {:PMID=>"22207904", :Title=>"Partial differential equation transform - Variational formulation and Fourier analysis.", :AuthorList=>"Yang Wang, Guo-Wei Wei, Siyang Yang", :Abstract=>"Nonlinear partial differential equation (PDE) models are established approaches for image/signal processing, data analysis and surface construction. Most previous geometric PDEs are utilized as low-pass filters which give rise to image trend information. In an earlier work, we introduced mode decomposition evolution equations (MoDEEs), which behave like high-pass filters and are able to systematically provide intrinsic mode functions (IMFs) of signals and images. Due to their tunable time-frequency localization and perfect reconstruction, the operation of MoDEEs is called a PDE transform. By appropriate selection of PDE transform parameters, we can tune IMFs into trends, edges, textures, noise etc., which can be further utilized in the secondary processing for various purposes. This work introduces the variational formulation, performs the Fourier analysis, and conducts biomedical and biological applications of the proposed PDE transform. The variational formulation offers an algorithm to incorporate two image functions and two sets of low-pass PDE operators in the total energy functional. Two low-pass PDE operators have different signs, leading to energy disparity, while a coupling term, acting as a relative fidelity of two image functions, is introduced to reduce the disparity of two energy components. We construct variational PDE transforms by using Euler-Lagrange equation and artificial time propagation. Fourier analysis of a simplified PDE transform is presented to shed light on the filter properties of high order PDE transforms. Such an analysis also offers insight on the parameter selection of the PDE transform. The proposed PDE transform algorithm is validated by numerous benchmark tests. In one selected challenging example, we illustrate the ability of PDE transform to separate two adjacent frequencies of sin(x) and sin(1.1x). Such an ability is due to PDE transform's controllable frequency localization obtained by adjusting the order of PDEs. The frequency selection is achieved either by diffusion coefficients or by propagation time. Finally, we explore a large number of practical applications to further demonstrate the utility of proposed PDE transform.", :Journal=>"Int j numer method biomed eng"}
    
      expect(@fetch.structure(@detail)).to eq(expected)
    end
  end
  
  context "abst" do
    it "check return when abstract is hash" do
      expected = "Nonlinear partial differential equation (PDE) models are established approaches for image/signal processing, data analysis and surface construction. Most previous geometric PDEs are utilized as low-pass filters which give rise to image trend information. In an earlier work, we introduced mode decomposition evolution equations (MoDEEs), which behave like high-pass filters and are able to systematically provide intrinsic mode functions (IMFs) of signals and images. Due to their tunable time-frequency localization and perfect reconstruction, the operation of MoDEEs is called a PDE transform. By appropriate selection of PDE transform parameters, we can tune IMFs into trends, edges, textures, noise etc., which can be further utilized in the secondary processing for various purposes. This work introduces the variational formulation, performs the Fourier analysis, and conducts biomedical and biological applications of the proposed PDE transform. The variational formulation offers an algorithm to incorporate two image functions and two sets of low-pass PDE operators in the total energy functional. Two low-pass PDE operators have different signs, leading to energy disparity, while a coupling term, acting as a relative fidelity of two image functions, is introduced to reduce the disparity of two energy components. We construct variational PDE transforms by using Euler-Lagrange equation and artificial time propagation. Fourier analysis of a simplified PDE transform is presented to shed light on the filter properties of high order PDE transforms. Such an analysis also offers insight on the parameter selection of the PDE transform. The proposed PDE transform algorithm is validated by numerous benchmark tests. In one selected challenging example, we illustrate the ability of PDE transform to separate two adjacent frequencies of sin(x) and sin(1.1x). Such an ability is due to PDE transform's controllable frequency localization obtained by adjusting the order of PDEs. The frequency selection is achieved either by diffusion coefficients or by propagation time. Finally, we explore a large number of practical applications to further demonstrate the utility of proposed PDE transform."
      puts @detail
      res = @detail[0][:MedlineCitation]
      
      expect(@fetch.abst(res)).to eq(expected)
    end
    
  end
    
end
