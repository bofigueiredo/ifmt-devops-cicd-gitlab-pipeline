package br.edu.ifmt.cicd.pessoa;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "pessoa")
@Data
@NoArgsConstructor
@AllArgsConstructor()
public class Pessoa {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY) 
  private Long id;

  private String nome;

  private String email;

}
