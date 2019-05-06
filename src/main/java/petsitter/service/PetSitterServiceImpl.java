package petsitter.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import petsitter.dao.PetSitterDAO;
import petsitter.dto.PetSitterDTO;

@Service
public class PetSitterServiceImpl implements PetSitterService {
@Autowired PetSitterDAO dao;

@Override
public List<PetSitterDTO> list() {
	// TODO Auto-generated method stub
	return dao.list();
}

@Override
public boolean insert_siiter(PetSitterDTO dto) {
	// TODO Auto-generated method stub
	return dao.insert_siiter(dto);
}

@Override
public boolean delete_sitter(int si_id) {
	// TODO Auto-generated method stub
	return dao.delete_sitter(si_id);
}
}
