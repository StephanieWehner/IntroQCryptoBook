include("../../source/eVec.jl");
include("rawImage.jl");
include("braPT.jl");
include("ketPT.jl");
include("partialTrace_middle.jl");

key_ex5 = rand(0:1,64,64);
encryptedImage = (rawImage + key_ex5) .% 2;
