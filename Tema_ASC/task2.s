.data
  id: .space 4
  kb: .space 4
  v: .space 1048576
  w: .space 1048576
  n: .space 4
  nr: .space 4
  nr_casute: .space 4
  nr_operatii: .space 4
  operatie: .space 4
  formatScanf: .asciz "%d"
  formatPrintfEroare: .asciz "Eroare. Introdu o comanda valida.\n"
  formatPrintf1: .asciz "%d: ((%d, %d), (%d, %d))\n"
  formatPrintf2: .asciz "((%d, %d), (%d, %d))\n"
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
    movl $1024, %esi
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
      sub $8, %esp
      cmpl $0, kb
      je add_loop_continue_conditie
      movl %eax, nr_casute
      cmp $0, %edx
      je verificare_loop1
      incl nr_casute

      verificare_loop1:
        movl $0, 4(%esp)

        verificare_loop2:
          movl 4(%esp), %edx
          mov %edx, 0(%esp)

          add_while1:
            movl -12(%ebp), %eax
            mul %esi
            add 0(%esp), %eax
            xor %edx, %edx
            movb (%edi, %eax, 1), %dl
            cmp $0, %edx
            je et_intermediara_add
            cmpl $1024, 0(%esp)
            je et_intermediara_add
            incl 0(%esp)
            jmp add_while1

          et_intermediara_add:
            mov 0(%esp), %edx
            mov %edx, 4(%esp)

          add_while2:
            movl -12(%ebp), %eax
            mul %esi
            add 4(%esp), %eax
            xor %edx, %edx
            movb (%edi, %eax, 1), %dl
            cmp $0, %edx
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
            cmp nr_casute, %edx
            jge verificare_conditie
            cmp $0, %edx
            je verificare_conditie
            jmp verificare_loop2

          verificare_conditie:
            incl -12(%ebp)
            cmp nr_casute, %edx
            jge add_loop_continue_conditie
            cmpl $1024, 8(%esp)
            je add_loop_continue_conditie
            jmp verificare_loop1

        add_loop_continue_conditie:
          decl -12(%ebp)
          cmp $0, %edx
          jne add_loop_continue
          sub $4, %esp
          movl $0, 0(%esp)
          movl $0, 4(%esp)
          movl $0, 8(%esp)
          movl $0, 12(%esp)
          push id
          push $formatPrintf1
          call printf
          add $24, %esp
          incl -4(%ebp)
          jmp add_loop

        add_loop_continue:
          sub $4, %esp
          movl -12(%ebp), %edx
          movl 4(%esp), %ecx
          movl %ecx, 12(%esp)
          movl %edx, 0(%esp)
          movl %edx, 8(%esp)

          add_v_loop:
            cmpl $0, nr_casute
            je add_v_loop_exit
            movl 0(%esp), %eax
            mul %esi
            add 12(%esp), %eax
            movb id, %dl
            movb %dl, (%edi, %eax, 1)
            decl nr_casute
            incl 12(%esp)
            jmp add_v_loop

          add_v_loop_exit:
            decl 12(%esp)
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
    push %ebp
    mov %esp, %ebp
    movl $1024, %ebx
    push %ebx
    sub $24, %esp
    movl $0, -8(%ebp)

    get_while1:
      cmpl $1024, -8(%ebp)
      je conditie_nu_exista
      movl $0, -12(%ebp)

      get_while2:
        movl -8(%ebp), %eax
        mul %ebx 
        add -12(%ebp), %eax 
        xor %edx, %edx
        movb (%edi, %eax, 1), %dl
        cmpl %edx, id 
        je et_intermediara_get1
        cmpl $1024, -12(%ebp)
        je et_intermediara_get1
        incl -12(%ebp)
        jmp get_while2

      et_intermediara_get1:
        movl -12(%ebp), %edx
        movl %edx, 0(%esp)

      get_while3:
        movl -8(%ebp), %eax
        mul %ebx 
        add -12(%ebp), %eax
        xor %edx, %edx
        movb (%edi, %eax, 1), %dl
        cmpl %edx, id 
        jne et_intermediara_get2
        cmpl $1024, -12(%ebp)
        je et_intermediara_get2
        incl -12(%ebp)
        jmp get_while3

      et_intermediara_get2:
        movl -12(%ebp), %edx
        decl %edx
        movl %edx, 8(%esp)
        cmpl %edx, 0(%esp)
        jg et_reluare
        movl -8(%ebp), %edx
        movl %edx, 4(%esp)
        movl %edx, 12(%esp)
        movl 0(%esp), %edx
        movl 4(%esp), %ecx
        movl %ecx, 0(%esp)
        movl %edx, 4(%esp)
        movl 8(%esp), %edx
        movl 12(%esp), %ecx
        movl %ecx, 8(%esp)
        movl %edx, 12(%esp)
        cmpl $4, operatie
        je defragmentation_continue
        push $formatPrintf2
        call printf
        add $4, %esp
        jmp get_exit

      et_reluare:
        incl -8(%ebp)
        jmp get_while1

        conditie_nu_exista:
          movl $0, 0(%esp)
          movl $0, 4(%esp)
          movl $0, 8(%esp)
          movl $0, 12(%esp)
          push $formatPrintf2
          call printf
          add $4, %esp

      get_exit:
        add $24, %esp
        pop %ebx
        pop %ebp
        ret 

  delete:
    push $id
    push $formatScanf
    call scanf
    add $8, %esp
    movl $1024, %ebx 
    push %ebx
    push %ebp
    mov %esp, %ebp
    sub $8, %esp
    movl $0, -4(%ebp)

    delete_while1:
      cmpl $1024, -4(%ebp)
      je et_intermediara_delete2
      movl $0, -8(%ebp)

      delete_while2:
        movl -4(%ebp), %eax
        mul %ebx
        add -8(%ebp), %eax
        xor %edx, %edx
        movb (%edi, %eax, 1), %dl
        cmp id, %edx
        je delete_while3
        cmpl $1024, -8(%ebp)
        je delete_while3
        incl -8(%ebp)
        jmp delete_while2

      delete_while3:
        movl -4(%ebp), %eax
        mul %ebx
        add -8(%ebp), %eax
        xor %edx, %edx
        movb (%edi, %eax, 1), %dl
        cmp id, %edx
        jne et_intermediara_delete1
        cmpl $1024, -8(%ebp)
        je et_intermediara_delete1
        xor %ecx, %ecx
        movb %cl, (%edi, %eax, 1)
        incl -8(%ebp)
        jmp delete_while3

      et_intermediara_delete1:
        incl -4(%ebp)
        jmp delete_while1

    et_intermediara_delete2:
      movl $0, -4(%ebp)

      delete_while4:
        cmpl $1024, -4(%ebp)
        je delete_exit
        movl $0, -8(%ebp)

        delete_while5:
          cmpl $1024, -8(%ebp)
          je delete_loop_continue1
          movl -4(%ebp), %eax
          mul %ebx
          add -8(%ebp), %eax 
          xor %ecx, %ecx
          movb (%edi, %eax, 1), %cl
          movl %ecx, id
          cmpl $0, id
          je delete_loop_continue2
          sub $8, %esp 
          movl -8(%ebp), %edx
          movl %edx, -12(%ebp)
          movl -4(%ebp), %edx
          movl %edx, 0(%esp)

          delete_while6:
            movl -4(%ebp), %eax
            mul %ebx 
            add -8(%ebp), %eax
            xor %edx, %edx
            movb (%edi, %eax, 1), %dl
            cmpl id, %edx
            jne delete_loop_continue3
            cmpl $1024, -8(%ebp)
            je delete_loop_continue3
            incl -8(%ebp)
            jmp delete_while6

          delete_loop_continue3:
            movl -8(%ebp), %edx
            decl %edx
            movl -4(%ebp), %eax
            movl %edx, -4(%ebp)
            movl %eax, -8(%ebp)
            push id
            push $formatPrintf1
            call printf
            movl -8(%ebp), %eax
            movl -4(%ebp), %edx
            movl %edx, -8(%ebp)
            movl %eax, -4(%ebp)
            add $16, %esp

            delete_loop_continue2:
              incl -8(%ebp)
              jmp delete_while5

          delete_loop_continue1:
            incl -4(%ebp)
            jmp delete_while4

  delete_exit:
    add $8, %esp
    pop %ebp
    pop %ebx
    ret

  defragmentation:
    mov $w, %esi
    xor %ecx, %ecx
    et_initializare_defragmentation:
      cmp $1048576, %ecx 
      je et_continue_defragmentation 
      movb $0, (%esi, %ecx, 1)
      incl %ecx 
      jmp et_initializare_defragmentation

    et_continue_defragmentation:
      sub $16, %esp
      push %ebp
      mov %esp, %ebp
      mov $1024, %ebx
      push %ebx
      movl $0, 8(%ebp)
      movl $0, 12(%ebp)
      movl $0, 16(%ebp)

      defragmentation_while1:
        movl $0, 4(%ebp)
        cmpl $1024, 8(%ebp)
        je defragmentation_prelucrare

        defragmentation_while2:
          cmpl $1024, 4(%ebp)
          je et_intermediara_defragmentation2
          movl 8(%ebp), %eax
          mul %ebx
          add 4(%ebp), %eax
          xor %edx, %edx
          movb (%edi, %eax, 1), %dl
          cmp $0, %edx
          jne pregatire_get
          incl 4(%ebp)
          jmp defragmentation_while2

        pregatire_get:
          movl %edx, id
          sub $24, %esp
          movl $0, -8(%ebp)
          jmp get_while1

        defragmentation_continue:
          mov $w, %edi 
          mov 12(%esp), %eax
          mov %eax, 4(%ebp)
          incl 4(%ebp)
          sub 4(%esp), %eax
          add $1, %eax
          mov %eax, nr_casute
          movl 0(%esp), %eax 
          movl %eax, 8(%ebp)
          add $24, %esp
          sub $4, %esp
          movl 16(%ebp), %eax
          movl %eax, 0(%esp)
          sub $8, %esp
          movl 12(%ebp), %eax
          movl %eax, 4(%esp)
          cmpl $0, 12(%ebp)
          jne verificare_defragmentation_loop2
          
          verificare_defragmentation_loop1:
            movl $0, 4(%esp)

            verificare_defragmentation_loop2:
              movl 4(%esp), %edx
              mov %edx, 0(%esp)
 
            add_defragmentation_while1:
              movl -8(%ebp), %eax
              mul %ebx
              add 0(%esp), %eax
              xor %edx, %edx
              movb (%edi, %eax, 1), %dl
              cmp $0, %edx
              je et_intermediara_add_defragmentation
              cmpl $1024, 0(%esp)
              je et_intermediara_add_defragmentation
              incl 0(%esp)
              jmp add_defragmentation_while1

            et_intermediara_add_defragmentation:
              mov 0(%esp), %edx
              mov %edx, 4(%esp)

          add_defragmentation_while2:
            movl -8(%ebp), %eax
            mul %ebx 
            add 4(%esp), %eax
            xor %edx, %edx
            movb (%edi, %eax, 1), %dl
            cmp $0, %edx
            jne et_if_defragmentation
            cmpl $1024, 4(%esp)
            je et_if_defragmentation
            incl 4(%esp)
            jmp add_defragmentation_while2

          et_if_defragmentation: 
            sub $4, %esp
            movl 8(%esp), %edx
            movl %edx, 0(%esp)
            movl 4(%esp), %edx
            sub %edx, 0(%esp)
            movl 0(%esp), %edx
            add $4, %esp
            cmp nr_casute, %edx
            jge verificare_conditie_defragmentation
            cmp $0, %edx
            je verificare_conditie_defragmentation
            jmp verificare_defragmentation_loop2

          verificare_conditie_defragmentation:
            incl -8(%ebp)
            cmp nr_casute, %edx
            jge add_loop_continue_conditie_defragmentation
            cmpl $1024, 8(%esp)
            je add_loop_continue_conditie_defragmentation
            jmp verificare_defragmentation_loop1

        add_loop_continue_conditie_defragmentation:
          decl -8(%ebp)
          cmp $0, %edx
          jne add_loop_continue_defragmentation 
          sub $4, %esp
          movl $0, 0(%esp)
          movl $0, 4(%esp)
          movl $0, 8(%esp)
          movl $0, 12(%esp)
          push id
          push $formatPrintf1
          call printf
          add $24, %esp

          add_loop_continue_defragmentation:
          sub $4, %esp
          movl -8(%ebp), %edx
          movl 4(%esp), %ecx
          movl %ecx, 12(%esp)
          movl %edx, 0(%esp)
          movl %edx, 8(%esp)

          add_v_loop_defragmentation:
            cmpl $0, nr_casute
            je add_v_loop_exit_defragmentation
            movl 0(%esp), %eax
            mul %ebx 
            add 12(%esp), %eax
            movb id, %dl
            movb %dl, (%edi, %eax, 1)
            decl nr_casute
            incl 12(%esp)
            jmp add_v_loop_defragmentation

          add_v_loop_exit_defragmentation:
            decl 12(%esp)
            push id
            push $formatPrintf1
            call printf
            movl -12(%ebp), %eax
            movl %eax, 16(%ebp)
            movl -8(%ebp), %eax
            movl %eax, 12(%ebp)
            incl 12(%ebp)
            add $24, %esp
            mov $v, %edi 
            jmp defragmentation_while2 

        et_intermediara_defragmentation2:
          incl 8(%ebp)
          jmp defragmentation_while1

      defragmentation_prelucrare:
        mov $v, %edi
        xor %ecx, %ecx

        defragmentation_while4:
          cmp $1048576, %ecx
          je defragmentation_exit
          xor %edx, %edx
          movb (%esi, %ecx, 1), %dl
          movb %dl, (%edi, %ecx, 1)
          incl %ecx
          jmp defragmentation_while4
          

    defragmentation_exit:
      pop %ebx
      pop %ebp
      add $16, %esp
      ret
    
.global main
main: 
  mov $v, %edi
  xor %ecx, %ecx
  et_initializare:
    cmp $1048576, %ecx
    je et_continue
    movb $0, (%edi, %ecx, 1)
    inc %ecx
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
    cmpl $1, operatie
    je et_call_add
    cmpl $2, operatie
    je et_call_get
    cmpl $3, operatie
    je et_call_delete
    cmpl $4, operatie
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
    xor %ebx, %ebx
    int $0x80
