from django.shortcuts import render

class AtmosphericDischargeSystem(generics.ListCreateAPIView):
    queryset = System.objects.all()
    serializer_class = SystemSerializer
    permission_classes = []
