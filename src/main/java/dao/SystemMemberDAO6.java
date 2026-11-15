package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.SystemMember6;

public class SystemMemberDAO6 extends DAO6 {
    public SystemMemberDAO6() {
        super();
    }

    public boolean checkLogin(SystemMember6 member) {
        boolean result = false;
        String sql = "SELECT * FROM tblSystemMember6 WHERE username = ? AND password = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, member.getUsername());
            ps.setString(2, member.getPassword());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                member.setId(rs.getInt("id"));
                member.setName(rs.getString("name"));
                member.setPhone(rs.getString("phone"));
                member.setEmail(rs.getString("email"));
                member.setRole(rs.getString("role"));
                result = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}