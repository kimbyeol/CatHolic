package pet.dao;

import java.util.List;

import pet.dto.PetDTO;



public interface PetDAO {
	 String insert_pet(PetDTO dto);
	 String update_pet(PetDTO dto);
	 List<PetDTO> list_pet(String owner);
	 String delete_pet(int id);
	 boolean insert_webpet(PetDTO dto);
}
