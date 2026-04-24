# 1. Kiem tra xem thu vien work da ton tai chua. Neu co thi xoa, sau do tao lai
if {[file exists work]} {
    vdel -all -lib work
}
vlib work

# 2. Bien dich toan bo source code RTL va Testbench CO BAT CO COVERAGE (-cover bcst)
vlog -cover bcst -work work ../rtl/*.v
vlog -cover bcst -work work testbench.v

# 3. Khoi chay mo phong voi che do Coverage kich hoat
vsim -coverage -voptargs="+acc" work.testbench

# 4. Them waveform (Tuy chon, de xem neu can)
add wave -position insertpoint sim:/testbench/DUT/*

# 5. Chay toan bo mo phong
run -all

# 6. Xuat bao cao Coverage ra dinh dang HTML de xem tren trinh duyet
coverage report -html -htmldir coverage_report_html -source -details

# 7. In tom tat Coverage ra man hinh Console
coverage report -summary