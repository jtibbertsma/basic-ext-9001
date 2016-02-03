#include "ruby.h"

#define GUTS_CAPA 15

struct guts {
  long size;
  VALUE stuff[GUTS_CAPA];
};

static VALUE eGutsError;

static void
guts_mark(void *p)
{
  struct guts *guts = p;
  int i;

  for (i = 0; i < guts->size; ++i) {
    rb_gc_mark(guts->stuff[i]);
  }
}

#define guts_free RUBY_DEFAULT_FREE

static size_t
guts_memsize(const void *p)
{
  return sizeof(struct guts);
}

static rb_data_type_t guts_type = {
  "the_guts",
  {
  guts_mark,
  guts_free,
  guts_memsize
  },
  0, 0, RUBY_TYPED_FREE_IMMEDIATELY | RUBY_TYPED_WB_PROTECTED
};

static VALUE
guts_allocate(VALUE klass)
{
  struct guts *ptr;
  VALUE obj = TypedData_Make_Struct(klass, struct guts, &guts_type, ptr);

  /* do initialization of p */

  return obj;
}

#define ACQUIRE_GUTS(obj) \
  struct guts *guts; \
  TypedData_Get_Struct(obj, struct guts, &guts_type, guts)

static VALUE
guts_pop(VALUE obj)
{
  ACQUIRE_GUTS(obj);

  if (guts->size <= 0) rb_raise(eGutsError, "The guts is empty");
  --guts->size;

  return guts->stuff[guts->size];
}

static VALUE
guts_push(VALUE obj, VALUE new_item)
{
  ACQUIRE_GUTS(obj);

  if (guts->size == GUTS_CAPA) rb_raise(eGutsError, "The guts is full");
  ++guts->size;
  RB_OBJ_WRITE(obj, &guts->stuff[guts->size], new_item);

  return Qnil;
}

static VALUE
guts_size(VALUE obj)
{
  ACQUIRE_GUTS(obj);

  long size = guts->size;
  return LONG2FIX(size);
}

void
Init_the_guts(void)
{
  VALUE mBasicExt9001, cGuts;

  mBasicExt9001 = rb_define_module("BasicExt9001");
  cGuts = rb_define_class_under(mBasicExt9001, "Guts", rb_cData);
  eGutsError = rb_define_class_under(mBasicExt9001, "GutsError", rb_eRuntimeError);

  rb_define_alloc_func(cGuts, guts_allocate);

  rb_define_method(cGuts, "pop", guts_pop, 0);
  rb_define_method(cGuts, "push", guts_push, 1);
  rb_define_method(cGuts, "size", guts_size, 0);

  rb_define_alias(cGuts, "length", "size");
}