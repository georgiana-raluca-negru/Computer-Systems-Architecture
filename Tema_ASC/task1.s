.data
  id: .space 4
  kb: .space 4
  v: .space 1024
  n: .space 4
  nr: .space 4
  nr_operatii: .space 4
  operatie: .space 4
  formatScanf: .asciz "%d"
  formatPrintfEroare: .asciz "Eroare. Introdu o comanda valida\n"
  formatPrintf1: .asciz "%d: (%d, %d)\n"
  formatPrintf2: .asciz "(%d, %d)\n"
.text 
  add:
      push $n
      push $formatScanf
      call scanf 
      add $8, %esp
      push n
      push %ebp
      mov %esp, %ebp
      sub $4, %esp
      movl $0, 0(%esp)
      movl $8, %ebx
      push %ebx

      add_loop:
        mov -4(%ebp), %ecx
        cmp 4(%ebp), %ecx
        je add_exit
        push $id 
        push $formatScanf
        call scanf
        add $8, %esp
        push $kb
        push $formatScanf
        call scanf
        add $8, %esp
        mov kb, %eax
        xor %edx, %edx
        div %ebx
        sub $4, %esp
        movl $0, 0(%esp)
        sub $4, %esp
        cmpl $0, kb
        je add_loop_continue_conditie
        cmp $0, %edx
        je verificare_loop
        incl %eax

          verificare_loop:
            movl 4(%esp), %edx
            movl %edx, 0(%esp)

            add_while1: 
              movl 0(%esp), %ecx
              xor %edx, %edx
              movb (%edi, %ecx, 1), %dl
              cmp $0, %edx
              je et_intermediara_add
              cmpl $1024, 0(%esp)
              je et_intermediara_add
              incl 0(%esp)
              jmp add_while1

            et_intermediara_add:
              movl 0(%esp), %edx
              movl %edx, 4(%esp)

            add_while2:
              movl 4(%esp), %ecx
              xor %edx, %edx
              movb (%edi, %ecx, 1), %dl
              cmpl $0, %edx
              jne et_if
              cmpl $1024, 4(%esp)
              je et_if
              incl 4(%esp)
              jmp add_while2

            et_if:
              sub $4, %esp
              movl 8(%esp), %edx
              movl %edx, 0(%esp)
              movl 4(%esp), %edx
              sub %edx, 0(%esp)
              movl 0(%esp), %edx
              add $4, %esp
              cmp %edx, %eax
              jle add_loop_continue_conditie
              cmpl $0, %edx
              je add_loop_continue_conditie
              jmp verificare_loop

          add_loop_continue_conditie:
            cmpl $0, %edx
            jne add_loop_continue
            movl $0, 4(%esp)
            movl $0, 0(%esp)
            push id
            push $formatPrintf1
            call printf
            add $16, %esp
            incl -4(%ebp)
            jmp add_loop

          add_loop_continue:
            movl 0(%esp), %edx
            movl %edx, 4(%esp)
            add $4, %esp
            sub $12, %esp
            movl %eax, 8(%esp)
            mov -12(%ebp), %eax
            movl %eax, 0(%esp)
            movl $0, 4(%esp)

          add_v_loop:
            cmpl $0, 8(%esp)
            je add_v_loop_exit
            mov -12(%ebp), %ecx
            movb id, %dl
            movb %dl, (%edi, %ecx, 1)
            decl 8(%esp)
            incl -12(%ebp)
            jmp add_v_loop

          add_v_loop_exit:
            movl -12(%ebp), %eax
            decl %eax
            movl %eax, 4(%esp)
            push id
            push $formatPrintf1
            call printf 
            add $24, %esp
            incl -4(%ebp)
            jmp add_loop

    add_exit:
      pop %ebx
      add $4, %esp
      pop %ebp
      add $4, %esp
      ret

  get:
    push $id
    push $formatScanf
    call scanf
    add $8, %esp
    push id 
    push %ebp
    mov %esp, %ebp
    sub $12, %esp
    movl $0, -4(%ebp)

    get_while1:
      movl -4(%ebp), %ecx
      xor %edx, %edx
      movb (%edi, %ecx, 1), %dl
      cmp 4(%ebp), %edx
      je et_intermediara_get1
      cmpl $1024, -4(%ebp)
      je afisare_nu_exista
      incl -4(%ebp)
      jmp get_while1

    et_intermediara_get1:
      movl -4(%ebp), %eax
      movl %eax, 0(%esp)

    get_while2:
      movl -4(%ebp), %ecx
      xor %edx, %edx
      movb (%edi, %ecx, 1), %dl
      cmp 4(%ebp), %edx
      jne et_intermediara_get2
      cmpl $1024, -4(%ebp)
      je et_intermediara_get2 
      incl -4(%ebp)
      jmp get_while2

    et_intermediara_get2:
      movl -4(%ebp), %eax
      decl %eax
      movl %eax, -8(%ebp)
      push $formatPrintf2
      call printf
      add $12, %esp
      jmp get_exit

    afisare_nu_exista:
     movl $0, 0(%esp)
     movl $0, 4(%esp)
     push $formatPrintf2
     call printf
     add $12, %esp
     jmp get_exit

    get_exit:
      add $4, %esp
      pop %ebp
      add $4, %esp
      ret
  
  delete:
    push $id
    push $formatScanf
    call scanf
    add $8, %esp
    push id
    push %ebp
    mov %esp, %ebp
    sub $4, %esp
    movl $0, -4(%ebp)

    delete_while1:
      movl -4(%ebp), %ecx
      xor %edx, %edx
      movb (%edi, %ecx, 1), %dl
      cmp $1024, %ecx
      je et_intermediara_delete
      cmpl 4(%ebp), %edx
      je delete_while2
      incl -4(%ebp)
      jmp delete_while1

    delete_while2:
      movl -4(%ebp), %ecx
      xor %edx, %edx
      movb (%edi, %ecx, 1), %dl
      cmp $1024, %ecx
      je et_intermediara_delete
      cmpl 4(%ebp), %edx
      jne et_intermediara_delete
      movb $0, (%edi, %ecx, 1)
      incl -4(%ebp)
      jmp delete_while2

    et_intermediara_delete:
      movl $0, -4(%ebp)
      sub $12, %esp
      
    delete_afisare:
      cmpl $1024, -4(%ebp)
      je delete_exit
      movl -4(%ebp), %ecx
      xor %edx, %edx
      movb (%edi, %ecx, 1), %dl
      movl %edx, 0(%esp)
      cmpl $0, 0(%esp)
      je delete_afisare_continue
      movl %ecx, -12(%ebp)

      delete_while3:
        movl -4(%ebp), %ecx
        xor %edx, %edx
        movb (%edi, %ecx, 1), %dl
        cmpl $1024, %ecx
        je afisare_propriu_zisa
        cmp %edx, 0(%esp)
        jne afisare_propriu_zisa
        incl -4(%ebp)
        jmp delete_while3

      afisare_propriu_zisa:
        decl -4(%ebp)
        movl -4(%ebp), %ecx
        movl %ecx, -8(%ebp)
        push $formatPrintf1
        call printf
        add $4, %esp
        jmp delete_afisare_continue

      delete_afisare_continue:
        incl -4(%ebp)
        jmp delete_afisare

    delete_exit:
      add $16, %esp
      pop %ebp
      add $4, %esp
      ret

  defragmentation:
    push %ebp
    mov %esp, %ebp
    sub $8, %esp
    movl $0, -4(%ebp)

    defragmentation_loop_i:
      cmpl $1023, -4(%ebp)
      je et_intermediara_defragmentation
      movl -4(%ebp), %ecx
      xor %eax, %eax
      movb (%edi, %ecx, 1), %al
      movl %ecx, -8(%ebp)
      incl -8(%ebp)

      defragmentation_loop_j:
        cmpl $1024, -8(%ebp)
        je defragmentation_loop_continue_i
        movl -8(%ebp), %ebx
        xor %edx, %edx
        movb (%edi, %ebx, 1), %dl
        cmpl $0, %eax
        jne defragmentation_loop_continue_i
        cmp $0, %edx
        je defragmentation_loop_continue_j
        movb %dl, (%edi, %ecx, 1)
        movb $0, (%edi, %ebx, 1)
        jmp defragmentation_loop_i

      defragmentation_loop_continue_j:
        incl -8(%ebp)
        jmp defragmentation_loop_j
      
    defragmentation_loop_continue_i:
      incl -4(%ebp)
      jmp defragmentation_loop_i

    et_intermediara_defragmentation:
      movl $0, -4(%ebp)
      add $4, %esp
      sub $12, %esp

    defragmentation_afisare:
      cmpl $1024, -4(%ebp)
      je defragmentation_exit
      movl -4(%ebp), %ecx
      xor %edx, %edx
      movb (%edi, %ecx, 1), %dl
      movl %edx, 0(%esp)
      cmpl $0, 0(%esp)
      je defragmentation_exit
      movl %ecx, -12(%ebp)

      defragmentation_while:
        movl -4(%ebp), %ecx
        xor %edx, %edx
        movb (%edi, %ecx, 1), %dl
        cmp $1024, %ecx
        je afisare_propriu_zisa_defragmentation
        cmp %edx, 0(%esp)
        jne afisare_propriu_zisa_defragmentation
        incl -4(%ebp)
        jmp defragmentation_while

      afisare_propriu_zisa_defragmentation:
        decl -4(%ebp)
        movl -4(%ebp), %ecx
        movl %ecx, -8(%ebp)
        push $formatPrintf1
        call printf
        add $4, %esp
        jmp defragmentation_afisare_continue

      defragmentation_afisare_continue:
        incl -4(%ebp)
        jmp defragmentation_afisare

      defragmentation_exit:
        add $16, %esp
        pop %ebp
        ret
        
.global main
main:
  mov $v, %edi
  xor %ecx, %ecx
  et_initializare:
    cmp $1024, %ecx
    je et_continue
    movb $0, (%edi, %ecx, 1)
    incl %ecx
    jmp et_initializare

  et_continue:
    push $nr_operatii
    push $formatScanf
    call scanf
    add $8, %esp
    xor %ecx, %ecx

    numar_operatii_loop:
      push %ecx
      cmp nr_operatii, %ecx
      je et_exit
      push $operatie
      push $formatScanf
      call scanf
      add $8, %esp
      movl operatie, %eax
      cmp $1, %eax
      je et_call_add
      cmp $2, %eax
      je et_call_get
      cmp $3, %eax
      je et_call_delete
      cmp $4, %eax
      je et_call_defragmentation
      push $formatPrintfEroare
      call printf
      add $4, %esp
      pop %ecx
      incl %ecx
      jmp numar_operatii_loop

      et_call_add:
        call add
        pop %ecx
        incl %ecx
        jmp numar_operatii_loop

      et_call_get:
        call get
        pop %ecx
        incl %ecx
        jmp numar_operatii_loop
        
      et_call_delete:
        call delete 
        pop %ecx
        incl %ecx
        jmp numar_operatii_loop

      et_call_defragmentation:
        call defragmentation
        pop %ecx
        incl %ecx
        jmp numar_operatii_loop

et_exit:
  pushl $0
  call fflush
  popl %eax
  
  mov $1, %eax
  mov $0, %ebx
  int $0x80
   