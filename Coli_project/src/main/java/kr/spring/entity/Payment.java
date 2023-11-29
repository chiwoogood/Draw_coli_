package kr.spring.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import lombok.Getter;
import lombok.AllArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@AllArgsConstructor
public class Payment {
    
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   private long ctn_id;

    @OneToOne
   @JoinColumn(name="Payment_id", referencedColumnName="username")
   private Member Payment_id;
    
    private String orderId;
    
    private Long amount;
    
    private String orderName;
    
    private String approvedAt;
    
    private String method;
    
}