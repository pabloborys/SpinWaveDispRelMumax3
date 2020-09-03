using CSV, DataFrames, FFTW, Glob, DSP, Plots

csv_files=glob("m_y*.csv","/home/pabloborys/Documents/AsymmetricDispersion/Processed_Data/Data_Mumax3/Ms_Middle_TG_H25.out/")
text_files=[]
for file in csv_files
    open(file,"r") do x
        push!(text_files,parse.(Float64,split(readline(x),",")))
    end
end
mx_mumax=zeros(Float64,length(text_files),length(text_files[1]))
for i in 1:length(text_files[1])
    for j in 1:length(text_files)
        mx_mumax[j,i]=text_files[j][i]
    end
end
hannx_mumax = hanning(size(mx_mumax,2))
hannt_mumax = hanning(size(mx_mumax,1))
for i in size(mx_mumax,1)
    mx_mumax[i, :] = mx_mumax[i, :] .* hannx_mumax
end
for i in size(mx_mumax,2)
    mx_mumax[:, i] = mx_mumax[:, i] .* hannt_mumax
end
mx_f_k_mumax=abs.(fftshift(fft(mx_mumax)))
mx_t_k=abs.(fftshift(fft(mx_mumax,[2])))
mx_f_x=abs.(fftshift(fft(mx_mumax,[1])))
CSV.write("/home/pabloborys/Documents/AsymmetricDispersion/Processed_Data/Ms/Sim_Mumax/mxt_Ms_Middle_TG_H25.csv",DataFrame(mx_mumax),writeheader=false)
CSV.write("/home/pabloborys/Documents/AsymmetricDispersion/Processed_Data/Ms/Sim_Mumax/mfk_Ms_Middle_TG_H25.csv",DataFrame(mx_f_k_mumax),writeheader=false)
CSV.write("/home/pabloborys/Documents/AsymmetricDispersion/Processed_Data/Ms/Sim_Mumax/mxf_Ms_Middle_TG_H25.csv",DataFrame(mx_f_x),writeheader=false)
CSV.write("/home/pabloborys/Documents/AsymmetricDispersion/Processed_Data/Ms/Sim_Mumax/mkt_Ms_Middle_TG_H25.csv",DataFrame(mx_t_k),writeheader=false)
#CSV.write("/home/pabloborys/Documents/Mumax3/TempGradient/Co_Pt/mtx_freqband_c_2exc.csv",DataFrame(mx_mumax),writeheader=false)
