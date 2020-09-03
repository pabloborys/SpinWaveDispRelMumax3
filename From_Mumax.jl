using CSV, DataFrames, FFTW, Glob, DSP, Plots

csv_files=glob("m_x*.csv","Path_to_directory_from_mumax3.out/")
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
mx_t_k_mumax=abs.(fftshift(fft(mx_mumax,[2])))
mx_f_x_mumax=abs.(fftshift(fft(mx_mumax,[1])))
CSV.write("Name_of_file_to_save_mx(x,t)",DataFrame(mx_mumax),writeheader=false)
CSV.write("Name_of_file_to_save_mx(k,f)",DataFrame(mx_f_k_mumax),writeheader=false)
CSV.write("Name_of_file_to_save_mx(x,f)",DataFrame(mx_f_x_mumax),writeheader=false)
CSV.write("Name_of_file_to_save_mx(k,t)",DataFrame(mx_t_k_mumax),writeheader=false)

