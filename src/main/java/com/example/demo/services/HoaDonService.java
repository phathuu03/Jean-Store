package com.example.demo.services;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.HoaDonChiTiet;
import com.example.demo.entity.QuanJeansChiTiet;
import com.example.demo.entity.Voucher;
import com.example.demo.repository.HoaDonRepository;
import com.example.demo.repository.QuanJeansChiTietRepository;
import com.example.demo.repository.VoucherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Date;
import java.util.List;

@Service
public class HoaDonService {

    @Autowired
    private HoaDonRepository hoaDonRepository;

    @Autowired
    QuanJeansChiTietRepository quanJeansChiTietRepository;

    @Autowired
    VoucherRepository voucherRepository;


    public Page<HoaDon> getAllHoaDon(Pageable pageable) {
        // Lấy tất cả hóa đơn (không phân trang)
        List<HoaDon> hoaDons = hoaDonRepository.findAll();

        // Đảo ngược danh sách
        Collections.reverse(hoaDons);

        // Tính toán phạm vi phân trang
        int start = pageable.getPageNumber() * pageable.getPageSize();
        int end = Math.min((start + pageable.getPageSize()), hoaDons.size());

        // Lấy một phần danh sách đã phân trang
        List<HoaDon> paginatedList = hoaDons.subList(start, end);

        // Tạo Page từ danh sách đã phân trang
        return new PageImpl<>(paginatedList, pageable, hoaDons.size());
    }

    public Page<HoaDon> getAll(Pageable pageable) {
        return hoaDonRepository.findAll(pageable);
    }

    public List<HoaDon> getAllHd(){
        return hoaDonRepository.findAll();
    }

    // Phương thức tìm kiếm hóa đơn với phân trang
    public Page<HoaDon> searchHoaDon(String search, Pageable pageable) {
        return hoaDonRepository.searchHoaDon(search, pageable);
    }

    public Page<HoaDon> getHoaDonByStatus(int status, Pageable pageable) {
        return hoaDonRepository.findByTrangThai(status, pageable);
    }

    public HoaDon findHoaDonById(Long id) {
        return hoaDonRepository.findById(id).get();
    }

    public void updateHoaDon(HoaDon hoaDon){
        hoaDonRepository.save(hoaDon);
    }



    public Boolean xacNhanTrangThai(Long idHoaDon, List<String> errorMessages) {
        HoaDon hd = findHoaDonById(idHoaDon);

        if (hd != null) {
            boolean allItemsAvailable = true;
            boolean voucherAvailable = true;
            String ghiChu = ""; // Khởi tạo ghi chú

            // Kiểm tra voucher trước
            if (hd.getVoucher() != null && hd.getVoucher().getSoLuong() <= 0) {
                errorMessages.add("Voucher đã hết số lượng.");
                voucherAvailable = false; // Voucher không còn đủ
                ghiChu += "Voucher không đủ. "; // Thêm ghi chú
            }

            // Kiểm tra từng sản phẩm chi tiết trong hóa đơn
            for (HoaDonChiTiet hoaDonChiTiet : hd.getHoaDonChiTiets()) {
                QuanJeansChiTiet chiTiet = hoaDonChiTiet.getQuanJeansChiTiet();
                Integer soLuongDatHang = hoaDonChiTiet.getSoLuong();
                Integer soLuongConLai = chiTiet.getSoLuong(); // Số lượng còn trong kho

                // Kiểm tra xem số lượng có đủ không
                if (soLuongDatHang > soLuongConLai) {
                    errorMessages.add("Sản phẩm " + chiTiet.getQuanJeans().getTenSanPham() + " không đủ số lượng.");
                    allItemsAvailable = false; // Nếu có sản phẩm thiếu, đánh dấu không đủ
                    ghiChu += "Hàng không đủ. "; // Thêm ghi chú
                    break; // Không cần kiểm tra các sản phẩm còn lại nữa
                }
            }

            // Kiểm tra cả hai điều kiện: đủ sản phẩm và đủ voucher
            if (allItemsAvailable && voucherAvailable) {
                // Trừ số lượng sản phẩm trong kho
                for (HoaDonChiTiet hoaDonChiTiet : hd.getHoaDonChiTiets()) {
                    QuanJeansChiTiet chiTiet = hoaDonChiTiet.getQuanJeansChiTiet();
                    Integer soLuongDatHang = hoaDonChiTiet.getSoLuong();
                    Integer soLuongConLai = chiTiet.getSoLuong(); // Số lượng còn trong kho

                    chiTiet.setSoLuong(soLuongConLai - soLuongDatHang);
                    quanJeansChiTietRepository.save(chiTiet); // Lưu thay đổi vào cơ sở dữ liệu
                }

                // Nếu có voucher, trừ số lượng voucher khi tất cả điều kiện được đáp ứng
                if (hd.getVoucher() != null && hd.getVoucher().getSoLuong() > 0) {
                    Voucher voucher = hd.getVoucher();
                    voucher.setSoLuong(voucher.getSoLuong() - 1); // Giảm số lượng voucher khi sử dụng
                    voucherRepository.save(voucher); // Lưu thay đổi vào cơ sở dữ liệu
                }
            }

            // Cập nhật trạng thái hóa đơn và ghi chú
            if (allItemsAvailable && voucherAvailable) {
                hd.setTrangThai(1); // Trạng thái "Chờ giao hàng"
                hd.setNgaySua(new Date());
                hd.setGhiChu("");  // Nếu mọi thứ ổn, ghi chú rỗng
                updateHoaDon(hd);
            } else {
                hd.setTrangThai(0); // Trạng thái "Đã hủy"
                hd.setGhiChu(ghiChu); // Cập nhật ghi chú theo trạng thái bị hủy
                updateHoaDon(hd); // Lưu trạng thái mới và ghi chú
            }

            // Lưu lại hóa đơn với trạng thái mới
            return allItemsAvailable && voucherAvailable; // Trả về true nếu tất cả điều kiện đều thỏa mãn
        }

        return false; // Trường hợp không tìm thấy hóa đơn
    }







    public Boolean huyDonHang(Long idHoaDon, String cancelReason) {
        HoaDon hd = findHoaDonById(idHoaDon);

        // Kiểm tra nếu hóa đơn tồn tại
        if (hd != null) {
            // Nếu trạng thái hóa đơn lớn hơn 1 (đã xác nhận), khôi phục lại số lượng sản phẩm
            if (hd.getPublicTrangThai() >= 1) {
                // Duyệt qua các sản phẩm chi tiết trong hóa đơn
                for (HoaDonChiTiet hoaDonChiTiet : hd.getHoaDonChiTiets()) {
                    QuanJeansChiTiet chiTiet = hoaDonChiTiet.getQuanJeansChiTiet();
                    Integer soLuongDatHang = hoaDonChiTiet.getSoLuong();
                    Integer soLuongConLai = chiTiet.getSoLuong(); // Số lượng còn trong kho

                    // Khôi phục lại số lượng sản phẩm đã bị trừ
                    chiTiet.setSoLuong(soLuongConLai + soLuongDatHang);
                    quanJeansChiTietRepository.save(chiTiet); // Lưu thay đổi vào cơ sở dữ liệu
                }
            }

            // Thay đổi trạng thái hóa đơn thành "Đã hủy" (trạng thái = 4)
            hd.setTrangThai(4);
            hd.setNgaySua(new Date());
            hd.setGhiChu("Cửa hàng đã hủy đơn hàng của bạn: " + cancelReason); // Lưu lý do hủy vào ghi chú
            updateHoaDon(hd); // Lưu lại hóa đơn với trạng thái và ghi chú mới

            return true; // Hủy đơn hàng thành công
        }

        return false; // Trường hợp không tìm thấy hóa đơn
    }




    public Boolean xnvc(Long idHoaDon)  {
       HoaDon hd = findHoaDonById(idHoaDon);
       if(hd!= null){
           hd.setTrangThai(2);
           hd.setNgaySua(new Date());
           updateHoaDon(hd);
           return true;
       }
       return  false;

    }

    public Boolean hoanThanhDonHang(Long idHoaDon)  {
       HoaDon hd = findHoaDonById(idHoaDon);
       if(hd!= null){
           hd.setTrangThai(3);
           hd.setNgayThanhToan(new Date());
           hd.setNgaySua(new Date());
           updateHoaDon(hd);
           return true;
       }
       return  false;

    }
}
