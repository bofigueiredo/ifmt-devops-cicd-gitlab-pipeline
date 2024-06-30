package br.edu.ifmt.cicd.pessoa;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/pessoa")
public class PessoaController {

  private final PessoaService pessoaService;

  public PessoaController(PessoaService pessoaService) {
    this.pessoaService = pessoaService;
  }

  @GetMapping
  public ResponseEntity<List<Pessoa>> findAll() {
	  List<Pessoa> pessoaList = pessoaService.findAll();
	  return ResponseEntity.status(200).body(pessoaList);
  }
  

}
