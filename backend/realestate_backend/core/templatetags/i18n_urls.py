from django import template
from django.urls import translate_url
from django.utils.translation import get_language

register = template.Library()

@register.simple_tag(takes_context=True)
def change_language_url(context, language):
    path = context['request'].path
    return translate_url(path, language)