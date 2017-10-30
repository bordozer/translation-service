package com.bordozer.translator.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Target;

import org.immutables.value.Value;

@Value.Style(builder = "new", create = "new")
@Target({ ElementType.TYPE, ElementType.PACKAGE, ElementType.ANNOTATION_TYPE })
public @interface DataModelStyle {

}
