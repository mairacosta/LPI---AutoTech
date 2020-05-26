package autotech;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

class Usuario {
	public int id;
	public String email, tipo, password;
	public ArrayList<String> telefones = new ArrayList<String>();
	
	public Usuario(int id, String email, String tipo) {
		this.id = id;
		this.email = email;
		this.tipo = tipo;
	}
	
	public Usuario(String email, String tipo, String password) {
		this.email = email;
		this.tipo = tipo;
		this.password = password;
	}

        public String getEmail() {
            return email;
        }

        public String getPassword() {
            return password;
        }
	
	public String getInfo() {
		String tels = "";
		for (String t : this.telefones) {
			tels += String.format("%s - ", t);
		}
		return String.format(
			"ID: %d\tEmail: %s\tTipo: %s\tTelefones: %s",
			id, email, tipo, tels
		);
	}
	
	public void adicionarTelefone(String telefone) {
		this.telefones.add(telefone);
	}
}

public class UsuarioDAO {

	public static ArrayList<Usuario> getUsuarios(Connection conexao) throws SQLException {
		Statement st_usuario = null, st_telefone = null;
		String query_usuario = "SELECT * FROM autotech.usuario";
		String query_telefone = "SELECT telefone FROM autotech.telefone WHERE usuario_id = ";
		ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
		
		try {
			st_usuario = conexao.createStatement();
			ResultSet rs = st_usuario.executeQuery(query_usuario);
			while (rs.next()) {
				Usuario usuario = new Usuario(
					rs.getInt("id"), rs.getString("email"), rs.getString("tipo")
				);
				st_telefone = conexao.createStatement();
				ResultSet rs_tels = st_telefone.executeQuery(query_telefone + usuario.id);
				while (rs_tels.next()) {
					usuario.adicionarTelefone(rs_tels.getString("telefone"));
				}
				usuarios.add(usuario);
			}
		} 
		catch (SQLException e ) {
			System.out.println("Erro! " + e);
	    } 
		finally {
	        if (st_usuario != null) st_usuario.close(); 
	        if (st_telefone != null) st_telefone.close(); 
	    }
		
		return usuarios;
	}

	public static Usuario getUsuario(Connection conexao, int idUsuario) throws SQLException {
		Statement st = null;
		String query = "SELECT * FROM autotech.usuario WHERE id = ";
		Usuario usuario = null;
		
		try {
			st = conexao.createStatement();
			ResultSet rs = st.executeQuery(query + idUsuario);
			if (rs.next()) {
				usuario = new Usuario(
					idUsuario, rs.getString("email"), rs.getString("tipo")
				);
			}
		} catch (SQLException e ) {
			System.out.println("Erro! " + e);
	    } finally {
	        if (st != null) st.close(); 
	    }
		return usuario;
	}
		
	public static boolean inserirUsuario(Connection conexao, String email, String tipo, String password) throws SQLException {
		PreparedStatement st = null;
		String query = "INSERT INTO autotech.usuario (email, tipo, password) VALUES (?, ?, ?)";
  
		try {
			st = conexao.prepareStatement(query);
			st.setString(1, email);
			st.setString(2, tipo);
			st.setString(3, password);
			st.execute();
			return true;
		} catch (SQLException e ) {
			return false;
	    }
	}
	
	public static boolean inserirTelefone(Connection conexao, int usuario_id, String telefone) throws SQLException {
		PreparedStatement st = null;
		String query = "INSERT INTO autotech.telefone (telefone, usuario_id) VALUES (?, ?)";

		try {
			st = conexao.prepareStatement(query);
			st.setString(1, telefone);
			st.setInt(2, usuario_id);
			st.execute();
			return true;
		} 
		catch (SQLException e ) {
			return false;
	    }
	}
}
