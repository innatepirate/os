#include <system.h>
struct idt_entry {
	unsigned short base_lo;
	unsigned short sel;
	unsigned char always0;
	unsigned char flags;
	unsigned short base_hi;
} STRUCT_PACKED;
struct idt_ptr{
	unsigned short limit;
	unsigned int base;
} STRUCT_PACKED;

struct idt_entry idt[256];
struct idt_ptr idtp;

extern void idt_load();

void idt_set_gate(unsigned char num, unsigned long base, unsigned short sel, unsigned char flags){
	/* The interrupt routine's base address */
	    idt[num].base_lo = (base & 0xFFFF);
	        idt[num].base_hi = (base >> 16) & 0xFFFF;

		    /* The segment or 'selector' that this IDT entry will use
		     *     *  is set here, along with any access flags */
		    idt[num].sel = sel;
		        idt[num].always0 = 0;
			    idt[num].flags = flags;
}
void idt_install() {
	idtp.limit = (sizeof(struct idt_entry) * 256) - 1;
	idtp.base = (int)&idt;
	
	memset((unsigned char*)&idt, (unsigned char)0, sizeof(struct idt_entry) * 256);

	idt_load();
}
